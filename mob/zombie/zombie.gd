extends CharacterBody3D

var player = null
var state_machine
var health = 5
var current_health = health

const SPEED = 7.0
const ATTACK_RANGE = 2

@onready var navigation_agent = $NavigationAgent3D
@onready var animation_tree = $AnimationTree
@onready var health_bar = $SubViewport/ProgressBar
@onready var marker_3d = $Marker3D
@onready var collision_shape_3d = $Armature/Skeleton3D/mremireh_body/Area3D/CollisionShape3D

var random_number

@export var experience_reward: int = 100 # Amount of XP this enemy gives
signal zombie_died(experience_reward)

var ui

func _ready():
	randomize()
	random_number = randi() % 2 + 1
	state_machine = animation_tree.get("parameters/playback")
	health_bar.max_value = health
	
func _process(delta):
	if !is_on_floor():
		velocity.y = 0.0
		
	
	velocity = Vector3.ZERO
	player = GameManager.player
	
	match state_machine.get_current_node():
		"Run":
			#navigation 
			navigation_agent.set_target_position(player.global_transform.origin)
			var next_nav_point = navigation_agent.get_next_path_position()
			velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
			rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), delta*10)
		"Attack":
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	
	#conditions
	animation_tree.set("parameters/conditions/attack", _target_in_range())
	animation_tree.set("parameters/conditions/run", !_target_in_range())
	
	move_and_slide()

func _on_normal_damage_taken(damage):
	MinosDamageNumbers3D.display_number(damage, marker_3d.global_position)

func _on_critical_damage_taken(damage):
	MinosDamageNumbers3D.display_number(damage, marker_3d.global_position, MinosDamageNumbers3D.DamageType.CRITICAL_HIT)

func _target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE
	
func _hit_finished():
	if global_position.distance_to(player.global_position) < ATTACK_RANGE + 1:
		var dir = global_position.direction_to(player.global_position)
		player.hit(dir)

#func _on_area_3d_body_part_hit(dam):
	#random_number = randi() % 2 + 1
	#health -= dam
	#health_bar.value = health
	#_on_critical_damage_taken(dam)
#
	#if health <= 0:
		#Global.score += 1
		## Connect the zombie_died signal to the player's gain_experience function
		#if not zombie_died.is_connected(Callable(player, "gain_experience")):
			#zombie_died.connect(Callable(player, "gain_experience")) 
		#zombie_died.emit(experience_reward)
		#
		#collision_shape_3d.call_deferred("set_disabled", true)
#
		#queue_free()


func _on_area_3d_zombie_hit(damage):
	random_number = randi() % 2 + 1
	health -= damage
	health_bar.value = health
	_on_critical_damage_taken(damage)

	if health <= 0:
		Global.score += 1
		# Connect the zombie_died signal to the player's gain_experience function
		if not zombie_died.is_connected(Callable(player, "gain_experience")):
			zombie_died.connect(Callable(player, "gain_experience")) 
		zombie_died.emit(experience_reward)
		
		collision_shape_3d.call_deferred("set_disabled", true)

		queue_free()

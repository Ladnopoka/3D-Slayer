extends CharacterBody3D

var player = null
var state_machine
var health = 3

const SPEED = 7.0
const ATTACK_RANGE = 2

@export var player_path := "/root/Level2/Rogue_Hooded"
@onready var navigation_agent = $NavigationAgent3D
@onready var animation_tree = $AnimationTree
@onready var health_bar = $SubViewport/ProgressBar

var random_number

@export var experience_reward: int = 60 # Amount of XP this enemy gives
signal knight_died(experience_reward)

var ui

func _ready():
	randomize()
	random_number = randi() % 2 + 1
	state_machine = animation_tree.get("parameters/playback")
	
func _process(delta):
	velocity = Vector3.ZERO
	player = GameManager.player
	
	match state_machine.get_current_node():
		"Running_A":
			#navigation 
			navigation_agent.set_target_position(player.global_transform.origin)
			var next_nav_point = navigation_agent.get_next_path_position()
			velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
			rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), delta*10)
		"1H_Melee_Attack_Chop":
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	
	#conditions
	animation_tree.set("parameters/conditions/attack", _target_in_range())
	animation_tree.set("parameters/conditions/run", !_target_in_range())
	
	move_and_slide()

func _target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE
	
func _hit_finished():
	if global_position.distance_to(player.global_position) < ATTACK_RANGE + 1:
		var dir = global_position.direction_to(player.global_position)
		player.hit(dir)

func _on_area_3d_body_part_hit(dam):
	random_number = randi() % 2 + 1
	health -= dam
	if health <= 0:
		Global.score += 1
		# Connect the knight_died signal to the player's gain_experience function
		knight_died.connect(Callable(player, "gain_experience"))	
		knight_died.emit(experience_reward)
		
		#$CollisionShape3D.disabled = true
		$Rig/Skeleton3D/Head/Area3D/CollisionShape3D.disabled = true
		$Rig/Skeleton3D/Body/Area3D/CollisionShape3D.disabled = true
		$Rig/Skeleton3D/Sword/Area3D/CollisionShape3D.disabled = true
		animation_tree.set("parameters/conditions/die", true)
		if random_number == 1:
			animation_tree.set("parameters/DeathStateMachine/conditions/die_a", true)
			await get_tree().create_timer(4.0).timeout
		else:
			animation_tree.set("parameters/DeathStateMachine/conditions/die_b", true)
			await get_tree().create_timer(7.0).timeout

		queue_free()

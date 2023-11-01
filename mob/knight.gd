extends CharacterBody3D

var player = null
var state_machine
var health = 3

const SPEED = 7.0
const ATTACK_RANGE = 2

@export var player_path := "/root/Level2/Rogue_Hooded"
@onready var navigation_agent = $NavigationAgent3D
@onready var animation_tree = $AnimationTree

func _ready():
	player = $"../../Rogue_Hooded"
	state_machine = animation_tree.get("parameters/playback")
	
func _process(delta):
	velocity = Vector3.ZERO
	
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
	print("BOOOM")
	health -= dam
	if health <= 0:
		animation_tree.set("parameters/conditions/die", true)
		await get_tree().create_timer(4.0).timeout
		queue_free()

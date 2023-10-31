extends CharacterBody3D

var player = null
var state_machine

const SPEED = 3.0
const ATTACK_RANGE = 2

@export var player_path : NodePath
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
			look_at(Vector3(global_position.x + velocity.x, global_position.y, 
							global_position.z + velocity.z), Vector3.UP)
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

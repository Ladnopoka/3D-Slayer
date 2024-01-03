extends CharacterBody3D

const SPEED = 3.0
const ATTACK_RANGE = 2.5

var player = null
var state_machine

@onready var navigation_agent = $NavigationAgent3D
@onready var animation_tree = $AnimationTree

func _ready():
	state_machine = animation_tree.get("parameters/playback")

func _process(delta):
	if player == null:
		return
		
	velocity = Vector3.ZERO

	match state_machine.get_current_node():
		"Run":
			navigation_agent.set_target_position(player.global_transform.origin)
			var next_nav_point = navigation_agent.get_next_path_position()
			velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
			rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), delta*10)
			look_at(Vector3(global_position.x + velocity.x, global_position.y,
							global_position.z + velocity.z), Vector3.UP)
		"Attack":
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)

	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	
	#Conditions
	animation_tree.set("parameters/conditions/attack", _target_in_range())
	animation_tree.set("parameters/conditions/run", !_target_in_range())
	
	move_and_slide()

func set_player(player_node):
	# Function to set the player reference from outside
	player = player_node
	
func _target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE

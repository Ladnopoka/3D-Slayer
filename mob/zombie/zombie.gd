extends CharacterBody3D

var player = null

const SPEED = 4.0

@export var player_path : NodePath
@onready var nav_agent = $NavigationAgent3D

func _ready():
	print("Player Path: ", player_path)
	player = $"../../../ThirdPersonPlayer"

func _physics_process(delta):
	velocity = Vector3.ZERO
	print("Velocity:", velocity)
	nav_agent.set_target_position(player.global_transform.origin)
	var next_nav_point = nav_agent.get_next_path_position()
	print("next_nav_point: ", next_nav_point)
	velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
	print("Velocity after next navigation: ", velocity)
	rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), delta*10)
	
	#look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	move_and_slide()

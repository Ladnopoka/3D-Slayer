extends CharacterBody3D

const SPEED = 3.0
var player = null

@onready var navigation_agent = $NavigationAgent3D

func _ready():
	player = $"../../../Mage"

func _process(delta):
	velocity = Vector3.ZERO

	navigation_agent.set_target_position(player.global_transform.origin)
	var next_nav_point = navigation_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
	rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), delta*10)

	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	

	
	move_and_slide()


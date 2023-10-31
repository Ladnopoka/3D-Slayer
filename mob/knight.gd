extends CharacterBody3D

var player = null
const SPEED = 3.0

@export var player_path : NodePath
@onready var navigation_agent = $NavigationAgent3D

func _ready():
	player = $"../../Rogue_Hooded"
	
func _process(delta):
	velocity = Vector3.ZERO
	navigation_agent.set_target_position(player.global_transform.origin)
	var next_nav_point = navigation_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
	move_and_slide()
	

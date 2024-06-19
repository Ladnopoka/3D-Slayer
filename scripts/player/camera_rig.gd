extends Node3D

@onready var background_viewport = $base_camera/background_viewpoint_container/background_viewport
@onready var foreground_viewport = $base_camera/foreground_viewpoint_container/foreground_viewport

@onready var background_camera = $base_camera/background_viewpoint_container/background_viewport/background_camera
@onready var foreground_camera = $base_camera/foreground_viewpoint_container/foreground_viewport/foreground_camera

# Called when the node enters the scene tree for the first time.
func _ready():
	resize()
	GameManager.connect("active_character_changed", _on_active_character_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if GameManager.player:
		background_camera.global_transform = GameManager.player.camera_point.global_transform
		foreground_camera.global_transform = GameManager.player.camera_point.global_transform
	else:
		print("Camera can't find player!")
	
func resize():
	background_viewport.size = DisplayServer.window_get_size()
	foreground_viewport.size = DisplayServer.window_get_size()

func _on_active_character_changed(new_player):
	print("Active character changed to: ", new_player.name)
	# Update the camera to follow the new player
	background_camera.global_transform = new_player.camera_point.global_transform
	foreground_camera.global_transform = new_player.camera_point.global_transform

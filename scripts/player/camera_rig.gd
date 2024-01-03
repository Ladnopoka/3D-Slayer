extends Node3D

@onready var background_viewport = $base_camera/background_viewpoint_container/background_viewport
@onready var foreground_viewport = $base_camera/foreground_viewpoint_container/foreground_viewport

@onready var background_camera = $base_camera/background_viewpoint_container/background_viewport/background_camera
@onready var foreground_camera = $base_camera/foreground_viewpoint_container/foreground_viewport/foreground_camera

# Called when the node enters the scene tree for the first time.
func _ready():
	resize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	background_camera.global_transform = GameManager.player.camera_point.global_transform
	foreground_camera.global_transform = GameManager.player.camera_point.global_transform
	
func resize():
	background_viewport.size = DisplayServer.window_get_size()
	foreground_viewport.size = DisplayServer.window_get_size()

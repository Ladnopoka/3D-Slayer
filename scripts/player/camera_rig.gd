extends Node3D

@onready var background_viewport = $base_camera/background_viewpoint_container/background_viewport
@onready var foreground_viewport = $base_camera/foreground_viewpoint_container/foreground_viewport

@onready var background_camera = $base_camera/background_viewpoint_container/background_viewport/background_camera
@onready var foreground_camera = $base_camera/foreground_viewpoint_container/foreground_viewport/foreground_camera
@onready var base_camera = $base_camera

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
	
func _input(event):
	if event is InputEventMouseButton:
		_handle_mouse_click(event.position)

func _handle_mouse_click(mouse_position):
	# Convert the 2D mouse position to a 3D ray
	var ray_origin = base_camera.project_ray_origin(mouse_position)
	var ray_end = ray_origin + base_camera.project_ray_normal(mouse_position) * 1000
	
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = ray_origin
	ray_query.to = ray_end

	var space_state = get_world_3d().direct_space_state
	var result = space_state.intersect_ray(ray_query)
	
	if result.size() > 0:
		print("Raycast hit: ", result.collider.name, " at position: ", result.position)
	else:
		print("Raycast did not hit any object.")
		

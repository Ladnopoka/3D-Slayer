@tool
extends EditorPlugin

const panel = preload("res://addons/editor-plugin/panel.tscn")
var dockedScene

func _enter_tree():
	add_custom_type("Button1", "Button1", preload("res://addons/editor-plugin/Button1.gd"), preload("res://icon.svg"))
	dockedScene = panel.instantiate()
	print("Panel scene instantiated!")
	
	var button1 = dockedScene.get_child(0)
	button1.connect("pressed", create_wall)
	
	# Initial setup when the plugin is enabled
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, dockedScene)
	
	#var button1 = dockedScene.find_node($Button1)
	#button1.connect("pressed", create_wall)

func _exit_tree():
	remove_custom_type("Button1")
	# Clean up when the plugin is disabled
	remove_control_from_docks(dockedScene)
	dockedScene.free()

func get_plugin_name():
	return "IsometricRoomEditor"

func get_plugin_description():
	return "An editor for creating 3D isometric rooms and blocks."

func _build_docks():
	# Create your GUI controls here
	pass
	
func create_wall():
	print("Inside create wall")
	
	
	
	
	
	
	
	
	
	
	# Create a new MeshInstance node
	var wall = MeshInstance3D.new()
	
	# Create a CubeMesh for our wall
	var cube_mesh = BoxMesh.new()
	cube_mesh.size = Vector3(4, 2, 0.2) # adjust size as per your requirements
	wall.mesh = cube_mesh
	
	# Name the wall instance
	wall.name = "Wall"
	
	# Add it to the current active scene
	get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 1).add_child(wall)
	
	# Optional: If you want to select the wall after creation
	#get_editor_interface().get_selection().select(wall)

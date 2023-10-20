@tool
extends EditorPlugin

const panel = preload("res://addons/editor-plugin/panel.tscn")
var dockedScene

# Get the undo/redo object
var undo_redo = get_undo_redo()

func _enter_tree():
	add_custom_type("Button1", "Button1", preload("res://addons/editor-plugin/Button1.gd"), preload("res://icon.svg"))
	dockedScene = panel.instantiate()
	print("Panel scene instantiated!")
	
	var button1 = dockedScene.get_child(0)
	var button2 = dockedScene.get_child(1)
	button1.connect("pressed", create_wall)
	button2.connect("pressed", create_box)
	
	# Initial setup when the plugin is enabled
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, dockedScene)


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

	var current_scene = get_editor_interface().get_edited_scene_root()
	if current_scene:
		# Begin a new action called "Create Box"
		undo_redo.create_action("Create Wall")
		
		# For the "do" operation: Add the box to the scene
		undo_redo.add_do_method(current_scene, "add_child", wall)
		undo_redo.add_do_reference(wall)  # Ensure box is kept in memory
		
		# For the "undo" operation: Remove the box from the scene
		undo_redo.add_undo_method(current_scene, "remove_child", wall)
		undo_redo.add_undo_reference(wall)  # Ensure box is kept in memory
		
		# Commit the action with execution
		undo_redo.commit_action(true)
	else:
		print("No active scene!")
		
		
func create_box():
	print("Inside create box")

	# Create a new MeshInstance node
	var box = MeshInstance3D.new()

	# Create a CubeMesh for our box
	var cube_mesh = BoxMesh.new()
	box.mesh = cube_mesh

	# Name the box instance
	box.name = "Box"

	var current_scene = get_editor_interface().get_edited_scene_root()
	if current_scene:
		# Begin a new action called "Create Box"
		undo_redo.create_action("Create Box")
		
		# For the "do" operation: Add the box to the scene
		undo_redo.add_do_method(current_scene, "add_child", box)
		undo_redo.add_do_reference(box)  # Ensure box is kept in memory
		
		# For the "undo" operation: Remove the box from the scene
		undo_redo.add_undo_method(current_scene, "remove_child", box)
		undo_redo.add_undo_reference(box)  # Ensure box is kept in memory
		
		# Commit the action with execution
		undo_redo.commit_action(true)
	else:
		print("No active scene!")

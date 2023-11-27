@tool
extends EditorPlugin

const panel = preload("res://addons/editor-plugin/panel.tscn")
const RoomTemplate = preload("res://addons/editor-plugin/room_template/room_template.tscn")
const HideoutTemplate = preload("res://addons/editor-plugin/room_template/hideout.tscn")

var dockedScene
#var toggle_button: Button
var tab_container: TabContainer
var is_content_visible: bool = false  # Tracks whether the content is currently visible

var button1
var button2
var button3
var hideout_button

# Get the undo/redo object
var undo_redo = get_undo_redo()

func _enter_tree():
	dockedScene = panel.instantiate()
	print("RoomGenerator panel scene instantiated!")
	
	#toggle_button = dockedScene.get_node("ToggleButton")
	tab_container = dockedScene.get_node("TabContainer")
	tab_container.visible = true
	
	setup_button_connections()
	# Initial setup when the plugin is enabled
	add_control_to_dock(DOCK_SLOT_RIGHT_BL, dockedScene)

func setup_button_connections():
	# Connect the toggle button signal
	#toggle_button.connect("pressed", _on_toggle_button_pressed)

	button1 = dockedScene.get_child(0).get_child(0).get_child(0)
	button2 = dockedScene.get_child(0).get_child(0).get_child(1)
	button3 = dockedScene.get_child(0).get_child(1).get_child(0)
	hideout_button = dockedScene.get_child(0).get_child(0).get_child(2) 
	button1.connect("pressed", create_wall)
	button2.connect("pressed", create_box)
	button3.connect("pressed", create_room)
	hideout_button.connect("pressed", create_hideout)
	button1.visible = true
	button2.visible = true
	button3.visible = true
	hideout_button.visible = true


func _on_toggle_button_pressed():
	# Toggle the visibility state
	if !tab_container.visible:
		tab_container.visible = true
	elif tab_container.visible:
		tab_container.visible = false
	print("Toggle Button Pressed")

func _exit_tree():
	remove_custom_type("Button1")
	# Clean up when the plugin is disabled
	remove_control_from_docks(dockedScene)
	dockedScene.free()

func get_plugin_name():
	return "RoomGenerator"

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

	var current_scene = get_editor_interface().get_edited_scene_root()
	if current_scene:
				# Name the box instance with counting already existing boxes
		wall.name = "Wall_" + str(current_scene.get_child_count())
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
		wall.owner = current_scene
	else:
		print("No active scene!")
		
		
func create_box():
	print("Inside create box")

	# Create a new MeshInstance node
	var box = MeshInstance3D.new()

	# Create a CubeMesh for our box
	var cube_mesh = BoxMesh.new()
	box.mesh = cube_mesh

	var current_scene = get_editor_interface().get_edited_scene_root()
	if current_scene:
		# Name the box instance with counting already existing boxes
		box.name = "Box_" + str(current_scene.get_child_count())
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
		box.owner = current_scene
	else:
		print("No active scene!")
	
	
func create_room():
	var room = RoomTemplate.instantiate()
	var current_scene = get_editor_interface().get_edited_scene_root()

	if current_scene:
		room.name = "Room_1" + str(current_scene.get_child_count())

		# For undo/redo functionality:
		undo_redo.create_action("Create Room")
		undo_redo.add_do_method(current_scene, "add_child", room)
		undo_redo.add_do_reference(room)
		undo_redo.add_undo_method(current_scene, "remove_child", room)
		undo_redo.commit_action(true)
		room.owner = current_scene
	else:
		print("No active scene!")
		
		
func create_hideout():
	var hideout = HideoutTemplate.instantiate()
	var current_scene = get_editor_interface().get_edited_scene_root()

	if current_scene:
		hideout.name = "Hideout_1" + str(current_scene.get_child_count())

		# For undo/redo functionality:
		undo_redo.create_action("Create Hideout")
		undo_redo.add_do_method(current_scene, "add_child", hideout)
		undo_redo.add_do_reference(hideout)
		undo_redo.add_undo_method(current_scene, "remove_child", hideout)
		undo_redo.commit_action(true)
		hideout.owner = current_scene
	else:
		print("No active scene!")

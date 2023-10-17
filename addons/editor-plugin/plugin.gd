@tool
extends EditorPlugin

const panel = preload("res://addons/editor-plugin/panel.tscn")
var dockedScene

# Get the undo/redo object
var undo_redo = get_undo_redo()
var orphanage = Node.new()

func _enter_tree():
	get_tree().get_root().add_child(orphanage)  # Add the orphanage to the root
	add_custom_type("Button1", "Button1", preload("res://addons/editor-plugin/Button1.gd"), preload("res://icon.svg"))
	dockedScene = panel.instantiate()
	print("Panel scene instantiated!")
	
	var button1 = dockedScene.get_child(0)
	button1.connect("pressed", create_wall)
	
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
		# Begin a new action called "Create Wall"
		undo_redo.create_action("Create Wall")

		# Set up undo/redo steps
		undo_redo.add_do_method(current_scene, "add_child", wall)   # Do step to add the wall
		undo_redo.add_undo_method(current_scene, "remove_child", wall) # Undo step to remove the wall
		undo_redo.add_undo_method(self, "move_to_orphanage", wall) # Instead of deleting, move to orphanage

		# Commit the action
		undo_redo.commit_action()
	else:
		print("No active scene!")

# This function will move the wall to the orphanage (our "storage" Node) instead of deleting it
func move_to_orphanage(node):
	print("in orphan")
	if not node.get_parent():
		orphanage.add_child(node)

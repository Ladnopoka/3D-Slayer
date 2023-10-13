@tool
extends EditorPlugin

var block_scene = preload("res://block/block.tscn")
var button : Button
	
	# UI Elements
var spawn_button = Button.new()
var offset_x = LineEdit.new()
var offset_y = LineEdit.new()
var offset_z = LineEdit.new()

func _enter_tree():
	# Create the dock UI
	button = Button.new()
	button.text = "Spawn Block"
	button.connect("pressed", _on_spawn_button_pressed)
	
	# Add UI for offset configuration
	offset_x.placeholder_text = "Offset X"
	offset_y.placeholder_text = "Offset Y"
	offset_z.placeholder_text = "Offset Z"
	
	var vbox = VBoxContainer.new()
	vbox.add_child(spawn_button)
	vbox.add_child(offset_x)
	vbox.add_child(offset_y)
	vbox.add_child(offset_z)
	
	add_control_to_bottom_panel(vbox, "Block Spawner")
	
	
	# Add the UI to the top panel
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, button)

func _exit_tree():
	# Cleanup
	button.queue_free()

func _on_spawn_button_pressed():
	var block_instance = block_scene.instantiate()
	
	# Grab the current scene
	var current_scene = get_tree().get_edited_scene_root()
	
	# Get offsets from UI
	var offset = Vector3(float(offset_x.text), float(offset_y.text), float(offset_z.text))
	
	# Position the block using the specified offset
	block_instance.transform.origin = offset
	
	# Add block to the root of the current scene
	current_scene.add_child(block_instance)
	

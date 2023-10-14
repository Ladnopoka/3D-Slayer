@tool
extends EditorPlugin

const panel = preload("res://addons/editor-plugin/panel.tscn")
var dockedScene

func _enter_tree():
	add_custom_type("MyButton1", "Button1", preload("res://addons/editor-plugin/Button1.gd"), preload("res://icon.svg"))
	dockedScene = panel.instantiate()
	print("Panel scene instantiated!")
	# Initial setup when the plugin is enabled
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, dockedScene)

func _exit_tree():
	remove_custom_type("MyButton1")
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

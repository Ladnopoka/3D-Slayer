@tool
extends VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button1.connect("pressed", _on_button_1_pressed)
	$HBoxContainer/Button2.connect("pressed", _on_copy_pressed)


func _on_button_1_pressed():
	var new_name = NameGenerator.new_name()
	#$HBoxContainer/LineEdit.text = new_name
	$HBoxContainer/LineEdit.text = new_name
	print(new_name)


func _on_copy_pressed():
	var content = $HBoxContainer/LineEdit.text
	DisplayServer.clipboard_set(content)

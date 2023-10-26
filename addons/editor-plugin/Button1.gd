@tool
extends Button

signal custom_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	#pressed.connect(clicked)
	pass

func _on_pressed():
	emit_signal("custom_button_pressed")

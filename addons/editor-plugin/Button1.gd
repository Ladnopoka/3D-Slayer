@tool
extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	#pressed.connect(clicked)
	pass

func _on_pressed():
	print("You clicked me from _on_pressed() method!!")

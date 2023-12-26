extends Node3D

var selection_area = preload("res://player/selection_area.tscn")

# Called when the node enters the scene tree for the first time. 
func _ready():
	for character in $Characters.get_children():
		var selection_area_ins = selection_area.instantiate()
		character.add_child(selection_area_ins)
		print("Mage's children: ", character.get_children())
		

@tool
extends Node3D

@onready var grid_map = $GridMap

@export var start : bool = false : set = set_start
func set_start(val:bool):
	generate() #eventually generate a whole dungeon


@export var border_size : int = 20 : set = set_border_size
func set_border_size(val : int):
	border_size = val
	if Engine.is_editor_hint():
		visualize_border()
	
func visualize_border():
	for pos1 in range(-1, border_size+1):
		grid_map.set_cell_item(Vector3i(pos1, 0, -1), 3)
		grid_map.set_cell_item(Vector3i(pos1, 0, border_size), 3)
		grid_map.set_cell_item(Vector3i(border_size, 0, pos1), 3)
		grid_map.set_cell_item(Vector3i(-1, 0, pos1), 3)
	
	
func generate():
	print("generating")

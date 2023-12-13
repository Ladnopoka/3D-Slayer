@tool
extends Node3D

@export var start : bool = false : set = set_start
func set_start(val:bool)->void:
	generate()
	

@export var border_size : int = 20 : set = set_border_size
func set_border_size(val : int) -> void:
	border_size = val
	
func generate():
	print("generating")

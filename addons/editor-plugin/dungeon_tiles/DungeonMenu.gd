@tool
extends Node3D

@export var start : bool = false : set = set_start

func set_start(val:bool)->void:
	generate()
	
func generate():
	print("generating")

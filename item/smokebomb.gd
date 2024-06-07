extends Node3D

func _ready():
	pass
	
func _physics_process(delta):
	self.rotation.y += delta * 3

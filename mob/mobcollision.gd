extends CollisionShape3D

@export var damage := 1

signal body_hit(dam)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func hit():
	print("arf")
	emit_signal("body_hit", damage)

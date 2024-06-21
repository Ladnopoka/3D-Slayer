extends Area3D

@export var damage := 1

signal zombie_hit(damage)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func hit():
	emit_signal("zombie_hit", damage)

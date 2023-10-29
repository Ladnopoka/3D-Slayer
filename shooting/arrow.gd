extends Node3D

const SPEED = 40.0
const SPIN_SPEED = 720

@onready var arrow_2 = $arrow2
@onready var ray_cast_3d = $RayCast3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	#rotate(Vector3(0, 0, 1), deg_to_rad(SPIN_SPEED * delta))

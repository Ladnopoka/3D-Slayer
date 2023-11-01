extends Node3D

const SPEED = 40.0
const SPIN_SPEED = 720

@onready var arrow_2 = $arrow2
@onready var ray_cast_3d = $RayCast3D
@onready var gpu_particles_3d = $GPUParticles3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if ray_cast_3d.is_colliding():
		arrow_2.visible = false
		gpu_particles_3d.emitting = true
		await get_tree().create_timer(1.0).timeout
		queue_free()

func _on_timer_timeout():
	queue_free()

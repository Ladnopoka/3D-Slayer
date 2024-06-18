extends Node3D

@export var damage: int = 10

@export var damage_min: int = 1
@export var damage_max: int = 3

@onready var particles = $GPUParticles3D
@onready var area = $Area3D
@onready var timer = $Timer

func _ready():
	#timer.connect("timeout", _on_timer_timeout)
	#timer.start(0.25)  # Adjust as needed for your strike interval	
	pass

func _process(_delta):
	pass
	
func _on_timer_timeout():
	pass
	#area.monitoring = true
	#await 0.1
	#yield(get_tree().create_timer(0.1), "timeout")
	#
	#area.monitoring = false

func _on_area_3d_body_entered(body):
	print("!!!BODY ENTERED!!!  ", body)
	
	if body.is_in_group("enemy"):
		var random_damage = randi() % (damage_max - damage_min + 1) + damage_min
		if body.has_method("_on_area_3d_body_part_hit"):
			body._on_area_3d_body_part_hit(random_damage)
		particles.emitting = true


func _on_area_3d_body_exited(body):
	print("!!!BODY EXITED!!!  ", body)

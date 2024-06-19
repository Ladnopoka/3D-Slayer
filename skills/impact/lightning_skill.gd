extends Node3D

@export var damage: int = 10

@export var damage_min: int = 1
@export var damage_max: int = 3

@onready var particles = $GPUParticles3D
@onready var area = $Area3D

func _ready():
	pass

func _process(_delta):
	pass

func _on_area_3d_body_entered(body):
	print("!!!BODY ENTERED!!!  ", body)
	
	if body.is_in_group("enemy"):
		var random_damage = randi() % (damage_max - damage_min + 1) + damage_min
		if body.has_method("_on_area_3d_body_part_hit"):
			body._on_area_3d_body_part_hit(random_damage)
		particles.emitting = true


func _on_area_3d_body_exited(body):
	print("!!!BODY EXITED!!!  ", body)

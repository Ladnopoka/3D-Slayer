extends Node3D

@export var damage: int = 10

@onready var particles = $GPUParticles3D
@onready var area = $Area3D
@onready var timer = $Timer

func _ready():	
	# Start the timer to apply damage at intervals
	timer.wait_time = 0.3
	timer.timeout.connect(_on_timeout)
	timer.start()

func _process(delta):
	pass
	#if area.enter:
		#print("Lightning colliding")

# Dictionary to keep track of enemies in the area
var enemies_in_area = {}

#func _on_body_entered(body):
	#print("!!!BODY ENTERED!!!  ", body)
	### Check if the body is an enemy
	##if body.is_in_group("enemies"):
		### Add the enemy to the dictionary
		##enemies_in_area[body] = true

#func _on_body_exited(body):
	## Remove the enemy from the dictionary
	#if body in enemies_in_area:
		#enemies_in_area.erase(body)

func _on_timeout():
	# Apply damage to all enemies in the area
	for enemy in enemies_in_area.keys():
		if enemy:
			enemy.apply_damage(damage)


func _on_area_3d_body_entered(body):
	print("!!!BODY ENTERED!!!  ", body)


func _on_area_3d_body_exited(body):
	print("!!!BODY EXITED!!!  ", body)
	# Remove the enemy from the dictionary
	if body in enemies_in_area:
		enemies_in_area.erase(body)
		

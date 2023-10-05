extends Node3D

@export var Bullet : PackedScene
@export var muzzle_speed = 30
@export var ms_between_shots = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shoot()
	
func shoot():
	var new_bullet = Bullet.instantiate()
	new_bullet.global_transform = $Muzzle.global_transform
	#new_bullet.speed = muzzle_speed
	var scene_root = get_tree().get_root().get_children()[0]
	scene_root.add_child(new_bullet)

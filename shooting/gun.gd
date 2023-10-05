extends Node3D

@onready var rof_timer = $Timer
var can_shoot = true

@export var Bullet : PackedScene
@export var muzzle_speed = 15
@export var ms_between_shots = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	rof_timer.wait_time = ms_between_shots/1000.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func shoot():
	if can_shoot:
		var new_bullet = Bullet.instantiate()
		new_bullet.global_transform = $Muzzle.global_transform
		new_bullet.speed = muzzle_speed
		var scene_root = get_tree().get_root().get_children()[0]
		scene_root.add_child(new_bullet)
		print("Pew!")
		can_shoot = false
		rof_timer.start()


func _on_timer_timeout():
	can_shoot = true

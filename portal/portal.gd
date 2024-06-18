extends Area3D

var entered = false
@onready var transition = $"../Transition"

func _on_body_entered(_body):
	print("Entered.")
	entered = true


func _on_body_exited(_body):
	entered = false
	print("Exited.")
	
func _process(_delta):
	if entered == true:
		if Input.is_action_just_pressed("interact"):
			print("Pressed F")
			transition.get_node("AnimationPlayer").play("fade_out")
			await get_tree().create_timer(1.0).timeout
			get_tree().change_scene_to_file("res://level/level2/level_2.tscn")
			

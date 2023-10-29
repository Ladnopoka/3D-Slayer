extends Area3D

var entered = false

func _on_body_entered(body):
	print("Entered.")
	entered = true


func _on_body_exited(body):
	entered = false
	print("Exited.")
	
func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("interact"):
			print("Pressed F")
			get_tree().change_scene_to_file("res://level/level2/level_2.tscn")

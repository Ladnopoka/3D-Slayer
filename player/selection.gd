extends Area3D

@onready var animation_player = $"../AnimationPlayer"
@onready var character = get_parent()
signal character_selected

func _on_input_event(camera, event, position, normal, shape_idx):
	if event.is_action_pressed("primary_action"):
		animation_player.play("Cheer")
		emit_signal("character_selected", character.name)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Cheer":
		animation_player.play("Idle")

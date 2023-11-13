extends Area3D

@onready var animation_player = $"../AnimationPlayer"
@onready var character = get_parent()
@onready var character_selection_scene = get_tree().get_root().get_node("Level1")

signal character_selected

func _ready() -> void:
	connect("character_selected", character_selection_scene.character_selected)
	animation_player.connect("animation_finished", _on_animation_player_animation_finished)

func _on_input_event(camera, event, position, normal, shape_idx):
	
	#print("hover over character")
	#print(event)
	
	if event.is_action_pressed("right_mouse_clicked"):
		print("hover over character")
		animation_player.play("Cheer")
		emit_signal("character_selected", character.name)
		$Selection.show()
		
func hide_selection():
	$Selection.hide()
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Cheer":
		animation_player.play("Idle")

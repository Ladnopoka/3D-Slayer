extends Area3D

@onready var animation_player = $"../AnimationPlayer"
@onready var animation_tree = $"../AnimationTree"
@onready var character = get_parent()
@onready var character_selection_scene = get_tree().get_root().get_node("Level1")

signal character_selected

func _ready() -> void:
	connect("character_selected", character_selection_scene.character_selected)
	animation_player.connect("animation_finished", _on_animation_player_animation_finished)
	
	
func _input_event(camera, event, position, normal, shape_idx):
	print("hover over character")
	#printt("Event: ", event, event.is_action_type(), event.is_pressed(), event.is_released())

	
	#print(character)
	
	if Input.is_action_pressed("right_mouse_clicked"):
		print("action pressed on character")
		animation_tree.set("parameters/AttackStateMachine/conditions/cheer", true)
		emit_signal("character_selected", character.name)
		$Selection.show()
	elif Input.is_action_just_released("right_mouse_clicked"):
		animation_tree.set("parameters/AttackStateMachine/conditions/cheer", false)
		
		
func hide_selection():
	$Selection.hide()
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Cheer":
		animation_player.play("Idle")

extends Node3D

var selection_area = preload("res://player/selection_area.tscn")

const BARBARIAN = preload("res://player/barbarian/barbarian.tscn")
const MAGE = preload("res://player/mage/mage.tscn")
const ROGUE_HOODED = preload("res://player/rogue/rogue_hooded.tscn")
const ZOMBIE = preload("res://mob/zombie/zombie.tscn")

@onready var color_rect = $Control/ColorRect

var spawn_position = Vector3(0, 0.1, 10.5) # Update this to your desired spawn location
var zombie_spawn_position = Vector3(-15.919, 0.1, -3.455)
# Called when the node enters the scene tree for the first time. 
func _ready():
	print("cemetery instantiated: ", GameManager.player_name)
	load_character(GameManager.player_name)

func load_character(character_name: String):
	var char_instance
	var zombie_instance
	
	match character_name:
		"Mage":
			# Load and initialize Mage
			print("Loading Mage character")
			char_instance = MAGE.instantiate()
			#load_character("Mage")
		"Barbarian":
			# Load and initialize Barbarian
			print("Loading Barbarian character")
			char_instance = BARBARIAN.instantiate()
			#load_character("Barbarian")
		"Rogue_Hooded":
			# Load and initialize Rogue_Hooded
			print("Loading Rogue_Hooded character")
			char_instance = ROGUE_HOODED.instantiate()
			#load_character("Rogue_Hooded")
		_:
			print("No matching character name found")
			return
	
	# Add the character instance to the scene
	if char_instance:
		add_child(char_instance)
		char_instance.global_transform.origin = spawn_position
		
	zombie_instance = ZOMBIE.instantiate()
	zombie_instance.set_player(char_instance)
	add_child(zombie_instance)
	zombie_instance.global_transform.origin = zombie_spawn_position

func _on_player_player_hit():
	color_rect.visible = true
	await get_tree().create_timer(0.2).timeout
	color_rect.visible = false

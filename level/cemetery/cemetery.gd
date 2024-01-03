extends Node3D

@onready var spawns = $Map/Spawns
@onready var navigation_region_3d = $Map/NavigationRegion3D

var selection_area = preload("res://player/selection_area.tscn")

const BARBARIAN = preload("res://player/barbarian/barbarian.tscn")
const MAGE = preload("res://player/mage/mage.tscn")
const ROGUE_HOODED = preload("res://player/rogue/rogue_hooded.tscn")
const ZOMBIE = preload("res://mob/zombie/zombie.tscn")

@onready var color_rect = $Control/ColorRect

var zombie_instance
var spawn_position = Vector3(0, 0.1, 10.5) # Update this to your desired spawn location
var zombie_spawn_position = Vector3(-15.919, 0.1, -3.455)

var char_instance

# Called when the node enters the scene tree for the first time. 
func _ready():
	randomize()
	print("cemetery instantiated: ", GameManager.player_name)
	load_character(GameManager.player_name)

func load_character(character_name: String):	
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
	navigation_region_3d.add_child(zombie_instance)
	zombie_instance.global_transform.origin = zombie_spawn_position

func _get_random_child(parent_node):
	var random_id = randi() % parent_node.get_child_count()
	return parent_node.get_child(random_id)


func _on_zombie_spawn_timer_timeout():
	var spawn_point = _get_random_child(spawns).global_position
	zombie_instance = ZOMBIE.instantiate()
	zombie_instance.set_player(char_instance)
	zombie_instance.position = spawn_point
	navigation_region_3d.add_child(zombie_instance)

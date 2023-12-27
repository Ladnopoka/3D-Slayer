extends Node3D

var selection_area = preload("res://player/selection_area.tscn")

const BARBARIAN = preload("res://player/barbarian/barbarian.tscn")
const MAGE = preload("res://player/mage/mage.tscn")
const ROGUE_HOODED = preload("res://player/rogue/rogue_hooded.tscn")

var spawn_position = Vector3(0, 0.1, 10.5) # Update this to your desired spawn location

# Called when the node enters the scene tree for the first time. 
func _ready():
	print("cemetery instantiated: ", GameManager.player_name)
	load_character(GameManager.player_name)

func load_character(character_name: String):
	var char_instance
	
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
		# Or use: character_instance.transform.origin = spawn_position
		# If you need to adjust rotation or scale, you can do that here as well.
	
	#for character in $Characters.get_children():
		#var selection_area_ins = selection_area.instantiate()
		#character.add_child(selection_area_ins)
		#print("Mage's children: ", character.get_children())
		

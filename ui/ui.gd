extends CanvasLayer

@export var all_recipes:ResourceGroup

@onready var health_globe = get_node("HealthGlobe/GlobeFull/TextureProgressBar")
@onready var mana_globe = get_node("ManaGlobe/GlobeFull/TextureProgressBar")
@onready var label = $HealthGlobe/Label

var player
var level_num = 1
@onready var inventory_dialog = %InventoryDialog
@onready var crafting_dialog = %CraftingDialog

#Exp
@onready var experience_bar = $"XP Bar/Experience Bar"
@onready var experience_label = $"XP Bar/Experience Bar/Experience Label"

const RUNE_1 = preload("res://globals/game_data/item_data/crafting/recipes/resources/rune_1.tres")
const RUNE_2 = preload("res://globals/game_data/item_data/crafting/recipes/resources/rune_2.tres")
const RUNE_3 = preload("res://globals/game_data/item_data/crafting/recipes/resources/rune_3.tres")
const RUNE_4 = preload("res://globals/game_data/item_data/crafting/recipes/resources/rune_4.tres")

var _all_recipes:Array[Recipe] = []

func _unhandled_input(event):
	if event.is_action_pressed("inventory") && player == GameManager.player:
		if inventory_dialog.is_visible():
			inventory_dialog.hide()
		else:
			inventory_dialog.open(player.inventory)
			
	if event.is_action_pressed("crafting") && player == GameManager.player:
		if crafting_dialog.is_visible():
			crafting_dialog.hide()
		else:
			crafting_dialog.open_crafting(_all_recipes, player.inventory)

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $".."
	health_globe.max_value = player.hp
	health_globe.value = player.hp
	label.text = str(player.current_hp) + "/" + str(player.hp)
	experience_label.text = "Level: " + str(GameState.player_data["level"])
	
	all_recipes.load_all_into(_all_recipes)
	
	#for file in DirAccess.get_files_at("res://globals/game_data/item_data/crafting/recipes/resources/"):
		#var resource_file = "res://globals/game_data/item_data/crafting/recipes/resources/" + file
		#var recipe:Recipe = load(resource_file) as Recipe
		#_all_recipes.append(recipe)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	UpdateGlobes()
	UpdateExp()
	
func UpdateGlobes():
	var new_hp = player.current_hp
	health_globe.value = new_hp
	label.text = (str(int(new_hp))) + "/" + str(player.hp)

func UpdateExp():
	var new_exp = player.current_exp
	experience_bar.value = new_exp
	experience_label.text = "Level: " + str(GameState.player_data["level"])

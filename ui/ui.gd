extends CanvasLayer

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

const RUNE_1:Recipe = preload("res://globals/game_data/item_data/crafting/recipes/resources/rune_1.tres")
const STAFF:Recipe = preload("res://globals/game_data/item_data/crafting/recipes/resources/staff.tres")
#const AXE_2H:Recipe = preload("res://globals/game_data/item_data/resource/axe2h.tres")
#const RUNE_2:Recipe = preload("res://globals/game_data/item_data/resource/rune_2.tres")

func _unhandled_input(event):
	if event.is_action_released("inventory") && player == GameManager.player:
		if inventory_dialog.is_visible():
			inventory_dialog.hide()
		else:
			inventory_dialog.open(player.inventory)
			
	if event.is_action_released("crafting") && player == GameManager.player:
		if crafting_dialog.is_visible():
			crafting_dialog.hide()
		else:
			crafting_dialog.open([], player.inventory)

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $".."
	health_globe.max_value = player.hp
	health_globe.value = player.hp
	label.text = str(player.current_hp) + "/" + str(player.hp)
	experience_label.text = "Level: " + str(GameState.player_data["level"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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

extends CanvasLayer

@onready var health_globe = get_node("HealthGlobe/GlobeFull/TextureProgressBar")
@onready var mana_globe = get_node("ManaGlobe/GlobeFull/TextureProgressBar")
@onready var label = $HealthGlobe/Label

var player_preload = preload("res://player/mage/mage.tscn")
var player
var level_num = 1

@onready var inventory_dialog:InventoryDialog = %InventoryDialog

#Exp
@onready var experience_bar = $"XP Bar/Experience Bar"
@onready var experience_label = $"XP Bar/Experience Bar/Experience Label"

#func _unhandled_input(event):
	#if event.is_action_released("inventory"):
		#inventory_dialog.open(player.inventory)

# Called when the node enters the scene tree for the first time.
func _ready():
	player = player_preload.instantiate()
	print("PLAYER: ", player)
	health_globe.max_value = player.hp
	health_globe.value = player.hp
	label.text = str(player.current_hp) + "/" + str(player.hp)
	experience_label.text = "Level: " + str(GameState.player_data["level"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	UpdateGlobes()
	UpdateExp()
	if Input.is_action_just_pressed("inventory"):
		inventory_dialog.open(GameManager.player.inventory)
	
func UpdateGlobes():
	var new_hp = player.current_hp
	health_globe.value = new_hp
	label.text = (str(int(new_hp))) + "/" + str(player.hp)

func UpdateExp():
	var new_exp = player.current_exp
	experience_bar.value = new_exp
	experience_label.text = "Level: " + str(GameState.player_data["level"])

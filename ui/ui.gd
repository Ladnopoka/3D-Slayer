extends CanvasLayer

@onready var health_globe = get_node("HealthGlobe/GlobeFull/TextureProgressBar")
@onready var mana_globe = get_node("ManaGlobe/GlobeFull/TextureProgressBar")
@onready var label = $HealthGlobe/Label

var player

#Exp
@onready var experience_bar = %"Experience Bar"
@onready var experience_label = %"Experience Label"

func set_expbar(set_value = 1, set_max_value = 100):
	experience_bar.value = set_value
	experience_bar.max_value = set_max_value

func _on_knight_died(xp_reward: int):
	player.gain_experience(xp_reward)
	_update_experience_bar()

func _update_experience_bar():
	experience_bar.max_value = 100
	experience_bar.value = player.current_exp

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $".."
	health_globe.max_value = player.hp
	health_globe.value = player.hp
	label.text = str(player.current_hp) + "/" + str(player.hp)
	
	set_expbar(1, 100)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	UpdateGlobes()
	
func UpdateGlobes():
	var new_hp = player.current_hp
	health_globe.value = new_hp
	label.text = (str(int(new_hp))) + "/" + str(player.hp)

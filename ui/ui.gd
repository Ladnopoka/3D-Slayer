extends CanvasLayer

@onready var health_globe = get_node("HealthGlobe/GlobeFull/TextureProgressBar")
@onready var mana_globe = get_node("ManaGlobe/GlobeFull/TextureProgressBar")
#@onready var label = $HealthGlobe/Label

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $"../Rogue_Hooded"
	health_globe.max_value = player.hp
	health_globe.value = player.hp
	#label.text = str(player.current_hp) + "/" + str(player.hp)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	UpdateGlobes()
	
func UpdateGlobes():
	var new_hp = player.current_hp
	health_globe.value = new_hp
	#label.text = str(new_hp) + "/" + str(player.hp)

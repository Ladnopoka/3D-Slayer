extends Node3D

@onready var hit_rect = $Control/ColorRect
@onready var spawns = $Spawns
@onready var navigation_region = $NavigationRegion3D
@onready var transition = $Transition
@onready var score = $Score

var knight = load("res://mob/knight.tscn")
var knight_instance

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	get_player_character()
	#var player_ins = player.instantiate()
	#add_child(player_ins)
	#player_ins.position = $Marker3D.position
	transition.get_node("AnimationPlayer").play("fade_in")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score.text = "Knights Killed: " + str(Global.score) + "/100"


func _on_rogue_hooded_player_hit():
	hit_rect.visible = true
	await get_tree().create_timer(0.2).timeout
	hit_rect.visible = false

func _get_random_child(parent_node):
	var random_id = randi() % parent_node.get_child_count()
	return parent_node.get_child(random_id) 

func _on_knight_spawn_timer_timeout():
	var spawn_point = _get_random_child(spawns).global_position
	knight_instance = knight.instantiate()
	knight_instance.position = spawn_point
	navigation_region.add_child(knight_instance)
	
func get_player_character():
	#print("GameManager Player Name: ", GameManager.player_name)
	#match GameManager.player_name:
		#"Rogue_Hooded":
			#player = load("res://player/rogue/rogue_hooded.tscn")
		#"Barbarian":
			#player = load("res://player/barbarian/barbarian.tscn")
		#"Mage":
			#player = load("res://player/mage/mage.tscn")
		#_:
			#player = load("res://player/barbarian/barbarian.tscn")
	pass

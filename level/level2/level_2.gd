extends Node3D

@onready var hit_rect = $Control/ColorRect
@onready var spawns = $Spawns
@onready var navigation_region = $NavigationRegion3D
@onready var transition = $Transition
@onready var score = $Score
@onready var wave_timer = $WaveTimer

var knight = load("res://mob/knight.tscn")
var knight_instance

const IMP = preload("res://mob/imp/imp.tscn")
var imp_instance

const ZOMBIE = preload("res://mob/zombie/zombie.tscn")
var zombie_instance

var player

var wave_interval = 2  # seconds between each wave
var current_time = 0
var wave_number = 0
var max_waves = 10  # Adjust based on your game's design

# Called when the node enters the scene tree for the first time.
func _ready():
	get_player_character()
	var player_ins = player.instantiate()
	add_child(player_ins)
	player_ins.position = $Marker3D.position
	player_ins.get_node("UI").visible = true
	player_ins.call("set_controlled", true)
	player_ins.current_exp = GameState.player_data["experience"]
	player_ins.current_hp = GameState.player_data["health"]
	player_ins.level = GameState.player_data["level"]
	transition.get_node("AnimationPlayer").play("fade_in")
	
	# Setup Wave Timer
	wave_timer.wait_time = wave_interval
	if !wave_timer.is_connected("timeout", _on_wave_timer_timeout):
		wave_timer.connect("timeout", _on_wave_timer_timeout)
	wave_timer.start()

func _on_wave_timer_timeout():
	if wave_number < max_waves:
		wave_number += 1
		spawn_wave()
		wave_timer.start()  # Restart the timer for the next wave
		
func spawn_wave():
	var spawn_count = wave_number * 2  # Adjust based on desired difficulty scaling
	for i in range(spawn_count):
		var spawn_point = _get_random_child(spawns).global_position
		var enemy_instance = choose_random_enemy().instantiate()
		enemy_instance.position = spawn_point
		navigation_region.add_child(enemy_instance)
		
func choose_random_enemy():
	var enemies = [ZOMBIE, knight] # Add all your enemy types here IMP, ZOMBIE, knight
	return enemies[randi() % enemies.size()]		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	score.text = "Knights Killed: " + str(Global.score) + "/100"
	current_time += _delta  # Increment the current time

func _get_random_child(parent_node):
	var random_id = randi() % parent_node.get_child_count()
	return parent_node.get_child(random_id) 

func _on_knight_spawn_timer_timeout():
	#var spawn_point = _get_random_child(spawns).global_position
	#imp_instance = IMP.instantiate()
	#imp_instance.position = spawn_point
	#navigation_region.add_child(imp_instance)
	#knight_instance = knight.instantiate()
	#knight_instance.position = spawn_point
	#navigation_region.add_child(knight_instance)
	#zombie_instance = ZOMBIE.instantiate()
	#zombie_instance.position = spawn_point
	#navigation_region.add_child(zombie_instance)
	pass
	
func get_player_character():
	print("GameManager Player Name: ", GameManager.player_name)
	match GameManager.player_name:
		"Rogue_Hooded":
			player = load("res://player/rogue/rogue_hooded.tscn")
		"Barbarian":
			player = load("res://player/barbarian/barbarian.tscn")
		"Mage":
			player = load("res://player/mage/mage.tscn")
		_:
			player = load("res://player/barbarian/barbarian.tscn")

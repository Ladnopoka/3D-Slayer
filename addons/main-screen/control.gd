@tool
extends VBoxContainer

const BlockScene = preload("res://block/block.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$RandomNameContainer/Button1.connect("pressed", _on_button_1_pressed)
	$RandomNameContainer/Button2.connect("pressed", _on_copy_pressed)
	$SpawnBlockContainer/Button3.connect("pressed", _on_spawn_block_pressed)


func _on_button_1_pressed():
	var new_name = NameGenerator.new_name()
	#$HBoxContainer/LineEdit.text = new_name
	$RandomNameContainer/LineEdit.text = new_name
	print(new_name)


func _on_copy_pressed():
	var content = $RandomNameContainer/LineEdit.text
	DisplayServer.clipboard_set(content)

func _on_spawn_block_pressed():
	#spawn_block_at_origin()
	spawn_block_next_to_player()
	
	
func spawn_block_next_to_player():
	print("Inside spawn block container")

	var block_instance = BlockScene.instantiate()
	get_tree().current_scene.add_child(block_instance)
	
	var player = get_tree().current_scene.get_node("Player")
	block_instance.global_transform.origin = player.global_transform.origin + Vector3(0, 0, 0)


func spawn_block_at_origin():
	print("Attempting to spawn block at origin")
	
	# Create an instance of the block
	var block_instance = BlockScene.instantiate()
	
	# Set the block's position to the origin
	block_instance.global_transform.origin = Vector3(0, 0, 0)
	
	# Add the block to the current scene
	get_tree().current_scene.add_child(block_instance)

	print("Block should be spawned at origin now.")

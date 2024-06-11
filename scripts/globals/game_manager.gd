extends Node

var player: Node
var player_name: String

signal active_character_changed(new_player)

func set_player(player_node):
	player = player_node
	print("Global Player: ", player, " Player Name: ", self.player_name)
	
func set_player_character(received_player_name):
	self.player_name = received_player_name

func set_active_character(character):
	player = character
	# You may also want to emit a signal indicating the player has changed, in case other parts of your game rely on this information
	emit_signal("active_character_changed", player)

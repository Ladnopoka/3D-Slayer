extends Node

var player: Node
var player_name: String

func set_player(player_node):
	player = player_node
	
func set_player_character(player_name):
	self.player_name = player_name

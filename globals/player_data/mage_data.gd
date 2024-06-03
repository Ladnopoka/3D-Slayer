extends Node

var player_data = {
	"experience": 0,
	"health": 100,
	"inventory": [],
	"position": Vector3.ZERO
}

func save_player_data(experience, inventory):
	player_data["experience"] = experience
	#player_data["health"] = health
	player_data["inventory"] = inventory
	#player_data["position"] = position

func load_player_data():
	return player_data

#var player: Node
#var player_name: String

#signal active_character_changed(new_player)
#
#func set_player(player_node):
	#player = player_node
	#print("Global Player: ", player, " Player Name: ", self.player_name)
	#
#func set_player_character(player_name):
	#self.player_name = player_name
#
#func set_active_character(character):
	#player = character
	## You may also want to emit a signal indicating the player has changed, in case other parts of your game rely on this information
	#emit_signal("active_character_changed", player)

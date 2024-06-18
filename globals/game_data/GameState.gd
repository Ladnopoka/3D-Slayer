extends Node

var player_data = {
	"experience": 0,
	"level": 1,
	"health": 100,
	"inventory": [],
	"position": Vector3.ZERO
}

var save_file_path = "C://Users//ladno//Desktop//godot_gamesave_files"

# Function to save game data to file
func save_game_data():
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	if file:
		#var json_instance = JSON.new()
		var json_string = JSON.stringify(player_data)
		file.store_string(json_string)
		file.close()
		print("Game data saved successfully.")
	else:
		print("Error saving game data.")

# Function to load game data from file
func load_game_data():
	var file = FileAccess.open(save_file_path, FileAccess.READ)
	if file:
		var json_string = file.get_as_text()
		var json_instance = JSON.new()
		var data = json_instance.parse(json_string)
		file.close()
		
		# Validate and apply loaded data
		if data.error == OK:
			var parsed_data = data.result
			if parsed_data is Dictionary:
				for key in player_data.keys():
					if parsed_data.has(key):
						player_data[key] = parsed_data[key]
						
			print("Game data loaded successfully.")
		else:
			print("Error parsing game data.")
	else:
		print("No save file found, using default data.")

# Function to update player data
func update_player_data(experience: int, level: int, health: int, inventory: Array):
	player_data["experience"] = experience
	player_data["level"] = level
	player_data["health"] = health
	player_data["inventory"] = inventory
	#player_data["position"] = position

# Function to add experience and level up if necessary
func add_experience(amount: int):
	player_data["experience"] += amount
	# Example level up logic
	if player_data["experience"] >= experience_needed_for_next_level():
		player_data["level"] += 1
		player_data["experience"] = 0  # Reset experience or adjust as needed

# Function to get the experience needed for the next level
func experience_needed_for_next_level() -> int:
	# Example formula for experience needed, adjust as necessary
	return player_data["level"] * 100

# Call this function to initialize and load data when the game starts
func _ready():
	load_game_data()

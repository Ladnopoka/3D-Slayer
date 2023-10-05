extends Node

class_name NameGenerator

static func pick_random(array):
	randomize()
	return array[randi() % array.size()]

static func new_name():
	var start = ['Re', 'Dar', 'Me', 'Su']
	var middle = ['ir', 'ton', 'me']
	var end = ['tz', 's', 'er']
	
	return pick_random(start) + pick_random(middle) + pick_random(end)
	

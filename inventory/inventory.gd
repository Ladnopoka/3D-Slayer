class_name Inventory

var _content:Array[Item] = []

signal item_added(item: Item)
signal item_removed(item: Item)

func add_item(item:Item):
	_content.append(item)
	emit_signal("item_added", item)
	
func remove_item(item:Item):
	_content.erase(item)
	emit_signal("item_removed", item)
	
func get_items() -> Array[Item]:
	return _content

func has_all(items:Array[Item]) -> bool:
	var needed:Array[Item] = items.duplicate()
	for available in _content:
		needed.erase(available)
		
	return needed.is_empty()

class_name InventoryDialog
extends PanelContainer

@export var slot_scene:PackedScene
@onready var grid_container:ItemGrid = %GridContainer

var _inventory:Inventory

func open(inventory:Inventory):	
	_inventory = inventory
	show()
	
	if _inventory:
		if not _inventory.is_connected("item_added", _on_item_changed):
			_inventory.connect("item_added", _on_item_changed)
		if not _inventory.is_connected("item_removed", _on_item_changed):
			_inventory.connect("item_removed", _on_item_changed)
			
	grid_container.display(inventory.get_items())

func _on_close_button_pressed():
	hide()
	# Disconnect signals when dialog is closed
	if _inventory:
		if _inventory.is_connected("item_added", _on_item_changed):
			_inventory.disconnect("item_added", _on_item_changed)
		if _inventory.is_connected("item_removed", _on_item_changed):
			_inventory.disconnect("item_removed", _on_item_changed)

func _on_item_changed(_item:Item):
	# Refresh the inventory display
	grid_container.display(_inventory.get_items())

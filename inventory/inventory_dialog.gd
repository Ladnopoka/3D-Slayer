class_name InventoryDialog
extends PanelContainer

@export var slot_scene:PackedScene
@onready var grid_container:ItemGrid = %GridContainer

var _inventory:Inventory

func open(inventory:Inventory):
	_inventory = inventory
	show()
	
	# Connect signals
	_inventory.connect("item_added",  _on_item_changed)
	_inventory.connect("item_removed", _on_item_changed)
	
	grid_container.display(inventory.get_items())

func _on_close_button_pressed():
	hide()

func _on_item_changed(item:Item):
	# Refresh the inventory display
	grid_container.display(_inventory.get_items())

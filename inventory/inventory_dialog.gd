class_name InventoryDialog
extends PanelContainer

@export var slot_scene:PackedScene
@onready var grid_container:GridContainer = %GridContainer

func open(inventory:Inventory):
	show()
	
	grid_container.display(inventory.get_items())

func _on_close_button_pressed():
	hide()

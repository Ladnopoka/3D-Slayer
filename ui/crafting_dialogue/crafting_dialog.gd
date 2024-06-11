class_name CraftingDialog
extends PanelContainer

@export var slot_scene:PackedScene

@onready var recipe_list:ItemList = %RecipeList
@onready var ingredients_container:GridContainer = %IngredientsContainer
@onready var results_container:GridContainer = %ResultsContainer
@onready var craft_button:Button = %"CraftButton"

var _inventory:Inventory
var _selected_recipe:Recipe

func open_crafting(recipes, inventory:Inventory):
	_inventory = inventory
	show()
	
	# Connect signals if not already connected
	if not _inventory.is_connected("item_added", _on_inventory_changed):
		_inventory.connect("item_added", _on_inventory_changed)
	if not _inventory.is_connected("item_removed", _on_inventory_changed):
		_inventory.connect("item_removed", _on_inventory_changed)
	
	recipe_list.clear()
	for recipe in recipes:
		var index = recipe_list.add_item(recipe.name)
		recipe_list.set_item_metadata(index, recipe)
		
	recipe_list.select(0)
	_on_recipe_list_item_selected(0)

func _on_close_button_pressed():
	hide()
	
		# Disconnect signals when dialog is closed
	if _inventory:
		if _inventory.is_connected("item_added", _on_inventory_changed):
			_inventory.disconnect("item_added", _on_inventory_changed)
		if _inventory.is_connected("item_removed", _on_inventory_changed):
			_inventory.disconnect("item_removed", _on_inventory_changed)
	## Disconnect signals when dialog is closed
	#if _inventory:
		#_inventory.disconnect("item_added", _on_inventory_changed)
		#_inventory.disconnect("item_removed", _on_inventory_changed)
	
func _on_recipe_list_item_selected(index):
	_selected_recipe = recipe_list.get_item_metadata(index) as Recipe
	if _selected_recipe:
		print("Selected recipe: ", _selected_recipe.name)
		ingredients_container.display(_selected_recipe.ingredients)
		results_container.display(_selected_recipe.results)
	else:
		print("Error: Could not cast to Recipe")
		
	craft_button.disabled = not _inventory.has_all(_selected_recipe.ingredients)
		
func _on_craft_button_pressed():
	for item in _selected_recipe.ingredients:
		_inventory.remove_item(item)
		
	for item in _selected_recipe.results:
		_inventory.add_item(item)
		
	craft_button.disabled = not _inventory.has_all(_selected_recipe.ingredients)
	
func _on_inventory_changed(item:Item):
	# Update the Craft button state whenever the inventory changes
	if _selected_recipe:
		craft_button.disabled = not _inventory.has_all(_selected_recipe.ingredients)
		
#func _on_item_changed(item:Item):
	## Refresh the inventory display
	#grid_container.display(_inventory.get_items())

class_name CraftingDialog
extends PanelContainer

@export var slot_scene:PackedScene

@onready var recipe_list:ItemList = %RecipeList
@onready var ingredients_container:GridContainer = %IngredientsContainer
@onready var results_container:GridContainer = %ResultsContainer

var _inventory:Inventory
var _selected_recipe:Recipe

func open_crafting(recipes, inventory:Inventory):
	_inventory = inventory
	show()
	
	recipe_list.clear()
	for recipe in recipes:
		var index = recipe_list.add_item(recipe.name)
		recipe_list.set_item_metadata(index, recipe)
		
	recipe_list.select(0)
	_on_recipe_list_item_selected(0)

func _on_close_button_pressed():
	hide()
	
func _on_recipe_list_item_selected(index):
	_selected_recipe = recipe_list.get_item_metadata(index) as Recipe
	if _selected_recipe:
		print("Selected recipe: ", _selected_recipe.name)
		ingredients_container.display(_selected_recipe.ingredients)
		results_container.display(_selected_recipe.results)
	else:
		print("Error: Could not cast to Recipe")
		
func _on_craft_button_pressed():
	for item in _selected_recipe.ingredients:
		_inventory.remove_item(item)
		
	for item in _selected_recipe.results:
		_inventory.add_item(item)

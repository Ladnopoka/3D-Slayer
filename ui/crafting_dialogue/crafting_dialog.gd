class_name CraftingDialog
extends PanelContainer

@export var slot_scene:PackedScene
@onready var grid_container:GridContainer = %GridContainer
@onready var recipe_list = %RecipeList
@onready var ingredients_container = %IngredientsContainer
@onready var results_container = %ResultsContainer

func open(recipes:Array[Recipe], inventory:Inventory):
	show()
	
	recipe_list.clear()
	for recipe in recipes:
		var index = recipe_list.add_item(recipe.name)
		recipe_list.set_item_metadata(index, recipe)

func _on_close_button_pressed():
	hide()


func _on_recipe_list_item_selected(index):
	var recipe:Recipe = recipe_list.get_item_metadata(index)

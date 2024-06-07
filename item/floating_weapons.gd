extends Node3D

@export var item:Item

func _ready():
	var scene_inst = item.scene.instantiate()
	print("SCENE INSTANCE: ", scene_inst)
	add_child(scene_inst)
	scene_inst.position = Vector3(10,1,7)
	print_tree()
	
#func _physics_process(delta):
	#self.rotation.y += delta * 3

func _on_area_3d_body_entered(body):
	if body.has_method("on_item_picked_up"):
		body.on_item_picked_up(item)
		queue_free()

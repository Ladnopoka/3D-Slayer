extends Node3D

@export var item_id:String

func _ready():
	var scene = load(Items.Database[item_id].scene)
	var scene_inst = scene.instantiate()
	add_child(scene_inst)
	
func _physics_process(delta):
	self.rotation.y += delta * 3

func _on_area_3d_body_entered(body):
	if body.has_method("on_item_picked_up"):
		body.on_item_picked_up(item_id)
		queue_free()

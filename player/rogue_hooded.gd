extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const ROTATION_SPEED = 7
const ACCELERATION = 8
const HIT_STAGGER = 25.0

@onready var camera_point = $camera_point
@onready var model = $Rig
@onready var anim_tree = $AnimationTree
@onready var anim_state = $AnimationTree.get("parameters/playback")
@onready var camera_rig = $camera_rig
@onready var crossbow = $Rig/RayCast3D

#signal
signal player_hit

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var jumping = false
var walking = false
var idling = false
var target_angle
var attacks = [
	"2H_Ranged_Aiming",
	"2H_Ranged_Reload",
	"2H_Ranged_Shoot",
	"2H_Ranged_Shooting"
]
var rayOrigin
var rayEnd
var mouse_position
var attack_direction

var arrow = load("res://shooting/arrow.tscn")
var arrow_instance

func _ready():
	GameManager.set_player(self)
	anim_tree.set("parameters/IWR/blend_position", Vector2(0, 0))
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	var model_rotation = model.rotation.y
	if direction.length() > 0.01:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

		target_angle = atan2(-direction.x, -direction.z)
		model_rotation = lerp_angle(model_rotation, target_angle, ROTATION_SPEED * delta)
		model.rotation.y = model_rotation
		
		# Set the blend position in the IWR blend space
		var vl = velocity * model.transform.basis
		anim_tree.set("parameters/IWR/blend_position", Vector2(vl.x, -vl.z) / SPEED)
		
		if !walking:
			walking = true
			idling = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
		if walking:
			anim_tree.set("parameters/IWR/blend_position", Vector2(0, 0)) # Reset to Idle position
			walking = false
			idling = true
			
	move_and_slide()
	if Input.is_action_pressed("primary_action"):
		attack()
	
	print("Walking: ", walking)
	print("Idle: ", idling)
	anim_tree.set("parameters/conditions/run", walking)
	
	
func attack():
	if walking:
		return
	
	var space_state = get_world_3d().direct_space_state
	mouse_position = get_viewport().get_mouse_position()
	
	rayOrigin = camera_rig.get_node("base_camera").project_ray_origin(mouse_position) # set the ray end point
	rayEnd = rayOrigin + camera_rig.get_node("base_camera").project_ray_normal(mouse_position) * 2000 # set the ray end point
	
	var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd); 
	var intersection = space_state.intersect_ray(query)
	
	if intersection.size() > 0:
		var pos = intersection.position
		model.look_at(Vector3(pos.x, pos.y, pos.z), Vector3(0,1,0))
		
	anim_state.travel(attacks[3])

	arrow_instance = arrow.instantiate()
	arrow_instance.position = crossbow.global_position
	arrow_instance.transform.basis = crossbow.global_transform.basis
	arrow_instance.rotate(Vector3(0, 1, 0), deg_to_rad(180))

	get_parent().add_child(arrow_instance)
	
func hit(dir):
	emit_signal("player_hit")
	velocity += dir * HIT_STAGGER

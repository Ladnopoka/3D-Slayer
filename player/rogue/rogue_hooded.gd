extends CharacterBody3D

const SPEED = 6.0
const JUMP_VELOCITY = 6.5
const ROTATION_SPEED = 7
const ACCELERATION = 8
const HIT_STAGGER = 25.0
const CROSSFADE_TIME = 0.1

var direction = Vector3.BACK
var velocity_var = Vector3.ZERO

@export var locomotionBlendPath: String;

@onready var camera_point = $camera_point
@onready var model = $Rig
@onready var anim_player = $AnimationPlayer
@onready var anim_tree = $AnimationTree
@onready var anim_tree_sm = anim_tree.get("parameters/AttackStateMachine/playback")
@onready var camera_rig = $camera_rig
@onready var transition = $Transition
@onready var ray_cast_3d = $Rig/RayCast3D

const ARROW = preload("res://shooting/arrow.tscn")
var arrow_inst
#signal
signal player_hit

var hp = 10
var hp_regen = 0.1
var current_hp
var is_dead = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var jumping = false
var walking = false
var idling = false
var target_angle
var rayOrigin
var rayEnd
var mouse_position
var attack_direction

var current_blend_position = Vector2(0, 0)
var target_blend_position = Vector2(0, 0)
var blend_lerp_speed = 1.0 / CROSSFADE_TIME

var attacking = false
var is_controlled = false

func _ready():
	GameManager.set_player(self)
	anim_tree.set(locomotionBlendPath, Vector2(0, 0))
	print("LOCOMOTIONBLENDPATH: ", locomotionBlendPath)
	current_hp = hp
	
func _physics_process(delta):
	if is_controlled:
		if !is_dead:
			#HPRegen(delta)
			movement_and_attacking(delta)
	
func movement_and_attacking(delta):
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
		
		# Set the blend position in the IWR blend space
		var vl = velocity * model.transform.basis
		target_blend_position = Vector2(-vl.x, vl.z) / SPEED
		
		walking = true
		idling = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
		if walking:
			target_blend_position = Vector2(0, 0) # Reset to Idle position
			walking = false
			idling = true
	
	current_blend_position = current_blend_position.lerp(target_blend_position, blend_lerp_speed * delta)
	anim_tree.set(locomotionBlendPath, current_blend_position)
	move_and_slide()
	
	if Input.is_action_pressed("right_mouse_clicked"):
		print("RM CLICKED")
	
	if Input.is_action_pressed("primary_action"):
		attack()
	elif Input.is_action_just_released("primary_action"):
		anim_tree.set("parameters/AttackStateMachine/conditions/attack", false)
		anim_tree.set("parameters/AttackStateMachine/conditions/stop_attack", true)

func attack():
	# Always update orientation, regardless of cooldown
	update_orientation()
	anim_tree.set("parameters/AttackStateMachine/conditions/attack", true)
	anim_tree.set("parameters/AttackStateMachine/conditions/stop_attack", false)

func update_orientation():
	# All the logic related to updating the character's orientation goes here
	var space_state = get_world_3d().direct_space_state
	mouse_position = get_viewport().get_mouse_position()

	rayOrigin = camera_rig.get_node("base_camera").project_ray_origin(mouse_position)
	rayEnd = rayOrigin + camera_rig.get_node("base_camera").project_ray_normal(mouse_position) * 2000

	var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd); 
	var intersection = space_state.intersect_ray(query)

	if intersection.size() > 0:
		var pos = intersection.position
		var direction_to_pos = pos - model.global_position

		if direction_to_pos.length() > 0.5:
			direction_to_pos.y = 0
			var look_at_pos = model.global_position + -direction_to_pos
			model.look_at(look_at_pos, Vector3(0, 1, 0))

func shoot_arrow():
	print("arrow is shooting (supposed to be omegalul)")
	arrow_inst = ARROW.instantiate()
	arrow_inst.position = ray_cast_3d.global_position
	arrow_inst.transform.basis = ray_cast_3d.global_transform.basis
	arrow_inst.rotate(Vector3(0, 1, 0), deg_to_rad(180))

	get_parent().add_child(arrow_inst)
	
func hit(dir):
	emit_signal("player_hit")
	velocity += dir * HIT_STAGGER
	
	current_hp -= 1
	if current_hp <= 0:
		die()
		current_hp = 0 # so life can't be -1
	print(current_hp)
	
func die():
	is_dead = true
	print("inside die")
	await get_tree().create_timer(4.0).timeout
	transition.get_node("AnimationPlayer").play("fade_out")
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://level/level_1.tscn")
	if Global.score > Global.best_score:
		Global.best_score = Global.score
		Global.score = 0
		Global.deaths += 1
	
func HPRegen(delta):
	current_hp += hp_regen * delta
	if current_hp > hp:
		current_hp = hp
		
func set_controlled(state: bool):
	is_controlled = state
	# Optionally, enable/disable the script directly
	# set_process(state)
	# set_physics_process(state)
	# Or if you're using nodes for input handling, you can enable/disable them as needed

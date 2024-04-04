extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
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
@onready var transition = $Transition
@onready var projectile_shooting_point = $Rig/RayCast3D
@onready var base_camera = $camera_rig/base_camera

var camera_rig = preload("res://player/camera_rig.tscn")
var camera_rig_ins

#signal
signal player_hit

var hp = 8
var hp_regen = 0.1
var current_hp
var is_dead = false

#projectile skills
var mage_skill = load("res://player/mage/mage_skill.tscn")
var mage_skill_instance
var mage_skill_cooldown_time = 0.5 # Cooldown time in seconds, e.g., 1 arrow per second.
var mage_skill_last_shot_time = -0.5 # A variable to keep track of the last shot time.

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
	current_hp = hp
	camera_rig_ins = camera_rig.instantiate()
	
func _physics_process(delta):
	if is_controlled:
		if !is_dead:
			HPRegen(delta)
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
		target_blend_position = Vector2(vl.x, -vl.z) / SPEED
		
		walking = true
		idling = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
		if walking:
			target_blend_position = Vector2(0, 0) # Reset to Idle position
			walking = false
			idling = true
	
	current_blend_position = current_blend_position.lerp(-target_blend_position, blend_lerp_speed * delta)
	anim_tree.set(locomotionBlendPath, current_blend_position)
	move_and_slide()
	
	if Input.is_action_pressed("right_mouse_clicked"):
		attack()
	elif Input.is_action_just_released("right_mouse_clicked"):
		anim_tree.set("parameters/AttackStateMachine/conditions/attack", false)	

func attack():
	# Always update orientation, regardless of cooldown
	update_orientation()
	anim_tree.set("parameters/AttackStateMachine/conditions/attack", true)

func shoot_projectile():
	mage_skill_instance = mage_skill.instantiate()
	mage_skill_instance.position = projectile_shooting_point.global_position
	mage_skill_instance.transform.basis = projectile_shooting_point.global_transform.basis
	get_parent().add_child(mage_skill_instance)

func update_orientation():
	# All the logic related to updating the character's orientation goes here
	var space_state = get_world_3d().direct_space_state
	mouse_position = get_viewport().get_mouse_position()

	var ray_origin = base_camera.project_ray_origin(mouse_position)
	var ray_end = ray_origin + base_camera.project_ray_normal(mouse_position) * 1000

	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end); 
	var intersection = space_state.intersect_ray(query)

	if intersection.size() > 0:
		var pos = intersection.position
		var direction_to_pos = pos - model.global_position

		if direction_to_pos.length() > 0.5:
			direction_to_pos.y = 0
			var look_at_pos = model.global_position + -direction_to_pos
			model.look_at(look_at_pos, Vector3(0, 1, 0))
	
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
	if state:
		anim_tree.active = true  # Ensure AnimationTree is active when the character is controlled
	else:
		# Option 1: Deactivate AnimationTree when character is not controlled
		anim_tree.active = false
		# Ensure AnimationPlayer plays the idle animation
		$AnimationPlayer.play("2H_Ranged_Aiming")

		# Option 2: Explicitly set AnimationTree to idle (if keeping it active)
		# Ensure the blend space is set to the idle position. This might involve setting
		# the locomotionBlendPath or other parameters to reflect an idle state.
		# anim_tree.set("parameters/locomotion/blend_position", Vector2.ZERO)

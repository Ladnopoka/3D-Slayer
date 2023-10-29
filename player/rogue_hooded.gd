extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const ROTATION_SPEED = 7
const ACCELERATION = 8

@onready var camera_point = $camera_point
@onready var model = $Rig
@onready var anim_tree = $AnimationTree
@onready var anim_state = $AnimationTree.get("parameters/playback")


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var jumping = false
var walking = false
var target_angle
var attacks = [
	"2H_Ranged_Aiming",
	"2H_Ranged_Reload",
	"2H_Ranged_Shoot",
	"2H_Ranged_Shooting"
]

var attack_direction

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
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
		if walking:
			anim_tree.set("parameters/IWR/blend_position", Vector2(0, 0)) # Reset to Idle position
			walking = false
			
	move_and_slide()
	if Input.is_action_just_pressed("primary_action"):
		attack()
	
func attack():
	var mouse_position = get_viewport().get_mouse_position()
#	#var world_mouse_position = camera_rig.unproject_position(mouse_position)
#
#	var direction = world_mouse_position - model.global_transform.origin
#	direction.y = 0 # Since we're not considering the y-axis.
#	direction = direction.normalized()
#
#	var target_angle = atan2(direction.x, direction.z)
#	model.rotation.y = target_angle
	
	anim_state.travel(attacks[3])

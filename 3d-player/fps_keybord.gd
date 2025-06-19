extends CharacterBody3D

@onready var camera_controller = $CameraController

const move_speed = 5.0
const jump_velocity = 4.5

var rotation_speed = 3.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var cam_dir = Input.get_vector("cam_left", "cam_right", "cam_up", "cam_down")
	rotation.y -= cam_dir.x * rotation_speed * delta
	camera_controller.rotation.x -= cam_dir.y * rotation_speed * delta
	camera_controller.rotation.x = clamp(camera_controller.rotation.x, deg_to_rad(-30), deg_to_rad(15))
	
	if direction:
		velocity.x = direction.x * move_speed
		velocity.z = direction.z * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.z = move_toward(velocity.z, 0, move_speed)

	move_and_slide()

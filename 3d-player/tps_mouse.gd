extends CharacterBody3D

@onready var spring_arm = $CameraController/SpringArm3D

const move_speed = 5.0
const jump_velocity = 4.5

var rotation_speed = 0.2
var min_arm = 1.0
var max_arm = 10.0
var arm_interval = 0.1

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * rotation_speed
		spring_arm.rotation_degrees.x -= event.relative.y * rotation_speed
		spring_arm.rotation_degrees.x = clamp(spring_arm.rotation_degrees.x, -30, 30)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	if Input.is_action_pressed("cam_zoom_in") and spring_arm.spring_length > min_arm:
		spring_arm.spring_length -= arm_interval
	if Input.is_action_pressed("cam_zoom_out") and spring_arm.spring_length < max_arm:
		spring_arm.spring_length += arm_interval

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * move_speed
		velocity.z = direction.z * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.z = move_toward(velocity.z, 0, move_speed)

	move_and_slide()

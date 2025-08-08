extends CharacterBody3D

# カメラ
@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity := 0.1 #0.25 # マウス感度
@export var camera_min := 0.02
@export var camera_max := 1.10

# キャラ移動
@export_group("Movement")
@export var move_speed := 8.0 # スピード
@export var acceleration := 20.0 # 加速度
@export var rotation_speed := 12.0 # 回転スピード
@export var jump_impulse := 12.0 # ジャンプ高

var _camera_input_direction := Vector2.ZERO
var _last_movement_direction := Vector3.BACK
var _gravity := -30.0

var arm_min = 1.0
var arm_max = 10.0
var arm_interval = 0.1

@onready var camera_pivot: Node3D = %CameraPivot
@onready var spring_arm: SpringArm3D = %SpringArm3D
@onready var camera_3d: Camera3D = %Camera3D
@onready var _skin: Node3D = $KnightModel
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback")

func _ready() -> void:
	add_to_group("player")
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("ui_cancel"):
		# マウスカーソル表示
#		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unhandled_input(event: InputEvent) -> void:
	# マウスが有効？の判定
	var is_camera_motion := (
		event is InputEventMouseMotion and 
		Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	if is_camera_motion:
		#_camera_input_direction = event.screen_relative * mouse_sensitivity
		_camera_input_direction.x = -event.relative.x * mouse_sensitivity
		_camera_input_direction.y = -event.relative.y * mouse_sensitivity

func _physics_process(delta: float) -> void:
	camera_pivot.rotation.x += _camera_input_direction.y * delta
	#camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, -PI / 6.0, PI / 3.0)
	camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, camera_min, camera_max)
	camera_pivot.rotation.y += _camera_input_direction.x * delta

	if Input.is_action_pressed("cam_zoom_in") and spring_arm.spring_length > arm_min:
		spring_arm.spring_length -= arm_interval
	if Input.is_action_pressed("cam_zoom_out") and spring_arm.spring_length <arm_max:
		spring_arm.spring_length += arm_interval

	_camera_input_direction = Vector2.ZERO
	
	var raw_input := Input.get_vector("move_left", "move_right", "move_up", "move_down", 0.4)
	var forward := camera_3d.global_basis.z
	var right := camera_3d.global_basis.x
	var move_direction := forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()

	if move_direction.length() > 0.2:
		_last_movement_direction = move_direction
	var target_angle := Vector3.BACK.signed_angle_to(_last_movement_direction, Vector3.UP)
	_skin.global_rotation.y = lerp_angle(_skin.global_rotation.y, target_angle, rotation_speed * delta)
	
	var y_velocity := velocity.y
	velocity.y = 0.0
	velocity = velocity.move_toward(move_direction * move_speed, acceleration * delta)
	velocity.y = y_velocity + _gravity * delta

	var is_starting_jump := Input.is_action_just_pressed("jump") and is_on_floor()
	if is_starting_jump:
		velocity.y += jump_impulse
		#_skin.jump()
		state_machine.travel("Jump")
	elif not is_on_floor() and velocity.y < 0:
		pass
	elif is_on_floor():
		var ground_speed := velocity.length()
		if ground_speed > 0.5:
			#animation_player.current_animation = "Idle"
			#_skin.move()
			state_machine.travel("Walking")
		else:
			#animation_player.current_animation = "Walking_C"
			#_skin.idle()
			state_machine.travel("Idle")

	move_and_slide()

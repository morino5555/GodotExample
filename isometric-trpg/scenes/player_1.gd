extends CharacterBody2D

@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 30.0

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1

	var isometric_movement = Vector2(
		(input_vector.x - input_vector.y),
		(input_vector.x + input_vector.y) / 2
	)

	#print(isometric_movement)
	if isometric_movement.x < 0:
		sprite_2d.flip_h = true
	elif isometric_movement.x > 0:
		sprite_2d.flip_h = false
	
	velocity = isometric_movement.normalized() * SPEED

	move_and_slide()

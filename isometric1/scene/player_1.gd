extends CharacterBody2D

const SPEED = 100.0

var direction:Vector2

func _physics_process(delta: float) -> void:
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	#direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	#direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	direction.y /= 2

	if direction:
		#velocity = direction.normalized() * SPEED
		var dir = cartesian_to_isometric(direction)
		velocity = dir.normalized() * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func cartesian_to_isometric(cartesion):
	return Vector2(cartesion.x - cartesion.y, (cartesion.x + cartesion.y) / 2)

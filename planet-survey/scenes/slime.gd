extends Area2D

const SPEED = 50.0
var direction = -1

@onready var game_manager: Node2D = %GameManager

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight

func _physics_process(delta: float) -> void:
	if !ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = true
	if !ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = false
	if !ray_cast_left.is_colliding() and !ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = false

	position.x += direction * SPEED * delta
	animated_sprite_2d.play("walk")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		game_manager.take_damage()

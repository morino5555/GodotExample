extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# キャラ
@export_group("Players")
@export var Move_Speed := 100.0 # 移動スピード

# マウス加速度
const Acceleration = 1400
const Mouse_Sensitivity = 5.0
# マウス摩擦度
const Friction = 1000
# Direction
var direction: Vector2

# Push
var Push_Force = 7

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	_move(_delta)

func _move(_delta: float) -> void:
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if direction:
		velocity.x = move_toward(velocity.x, Move_Speed * direction.x, Acceleration * _delta)
		velocity.y = move_toward(velocity.y, Move_Speed * direction.y, Acceleration * _delta)
	else :
		velocity.x = move_toward(velocity.x, Move_Speed * direction.x, Friction * _delta)
		velocity.y = move_toward(velocity.y, Move_Speed * direction.y, Friction * _delta)

	_set_animation()

	_push_object()
	
	move_and_slide()
	
func _set_animation():
	#animation_player.play("walk-front")
	if velocity.x < 0:
		animated_sprite_2d.flip_h = true
		animation_player.play("walk-side")
	elif velocity.x > 0:
		animated_sprite_2d.flip_h = false
		animation_player.play("walk-side")
	elif velocity.y < 0:
		animation_player.play("walk-back")
	elif velocity.y > 0:
		animation_player.play("walk-front")

func _push_object():
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var object_col = collision.get_collider()
		if object_col.is_in_group("PushObject"):
			object_col.apply_central_impulse(collision.get_normal() * -Push_Force)
			

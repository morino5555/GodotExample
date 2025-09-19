extends CharacterBody2D

const SPEED = 80.0
const JUMP_VELOCITY = -300.0
const DamageKnockback = -5.0

@onready var slime_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health_bar: ProgressBar = $HealthUI/HealthBar

var direction := 0.0

var is_face_right: bool = false
var was_face_right: bool = false

var isWall: bool = false

var maxHealth = 100
var health = 50

var isDamage = false
var isAttack = false

func _ready() -> void:
	add_to_group("Player")
	health_bar.set_health_bar(health, maxHealth)

func _physics_process(delta: float) -> void:
	# Gravity.
	if not is_on_floor() and not isWall:
		velocity += get_gravity() * delta

	# jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Attack.
	if Input.is_action_just_pressed("attack"):
		isAttack = true

	direction = Input.get_axis("move_left", "move_right")
	if is_on_wall():
		isWall = true
		if direction > 0:
			velocity.y = -direction * SPEED
		elif direction < 0:
			velocity.y = direction * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
	else:
		isWall = false
		if isDamage:
			direction = direction * DamageKnockback
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	_set_animation()

	move_and_slide()

func _set_animation():
	if velocity.y < 0:
		animation_player.play("jump")
	else :
		if velocity.x < 0:
			was_face_right = true
		elif velocity.x > 0:
			was_face_right = false
		if is_face_right != was_face_right:
			set_flip_h()

		if isDamage:
			slime_sprite.modulate = Color8(255, 67, 111)
			animation_player.play("hit")
			await get_tree().create_timer(0.3).timeout
			isDamage = false
			slime_sprite.modulate = Color(1, 1, 1)
		elif isAttack:
			animation_player.play("attack")
			await get_tree().create_timer(2.8).timeout
			isAttack = false
		else :
			if velocity.x:
				animation_player.play("walk")
			else :
				animation_player.play("idle")
	
func set_flip_h():
	is_face_right = !is_face_right
	scale.x = abs(scale.x) * -1

func take_damage(damage):
	health -= damage
	if health < 0:
		health = 0
		TransitionMgr.transition_to(get_tree().current_scene.scene_file_path)
	health_bar.change_health(-damage)
	isDamage = true
	_set_animation()

func take_heal(heal):
	health += heal
	health_bar.change_health(heal)
	slime_sprite.scale = Vector2(1.2, 1.2)
	await get_tree().create_timer(0.5).timeout
	slime_sprite.scale = Vector2(1.0, 1.0)

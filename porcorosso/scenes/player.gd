extends CharacterBody2D

# シグナル
signal destruction

# 移動スピード
const move_speed = 100.0
# 傾き
var turnTilt = 4
# HP
var health = 10

var direction: Vector2

# バレット
var canShoot = true 
const BULLET = preload("res://scenes/bullet.tscn")
@onready var marker_2d: Marker2D = $Marker2D
@onready var shoot_timer: Timer = $shootTimer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if direction.x:
		velocity = direction.normalized() * move_speed
		if direction.x < 0:
			rotation = -1 * turnTilt * delta
		elif direction.x > 0:
			rotation = 1 * turnTilt * delta
	elif direction.y:
		velocity = direction.normalized() * move_speed
		rotation = 0 * turnTilt * delta
	else :
		velocity = Vector2.ZERO

	# 攻撃
	if Input.is_action_pressed("shoot"):
		shoot()

	position += velocity * delta

	# 画面の外に行かないように	
	var viewRect = get_viewport_rect()
	var viewOffset = Vector2(50, 50)
	position = position.clamp(viewOffset, viewRect.size - viewOffset)

	move_and_slide()

func shoot():
	if canShoot:
		canShoot = false
		shoot_timer.start()
		audio_stream_player_2d.play()

		var bullet = BULLET.instantiate()
		bullet.set_position(marker_2d.global_position)
		get_parent().add_child(bullet)

func _on_shoot_timer_timeout() -> void:
	canShoot = true
	
func get_damage(damage):
	health -= damage
	#print("Play Damage")
	if health <= 0:
		destruction.emit()
		queue_free()

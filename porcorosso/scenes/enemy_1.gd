extends CharacterBody2D

# シグナル
signal enemy_destruction(points)

# 移動スピード
const move_speed = 30.0
# HP
var health = 3
# ポイント
var points = 10

var direction: Vector2

# バレット
var canShoot = true
const ENEMY_BULLET = preload("res://scenes/enemy_bullet.tscn")
@onready var marker_2d: Marker2D = $Marker2D
@onready var shoot_timer: Timer = $shootTimer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	add_to_group("enemies")

func _physics_process(delta: float) -> void:
	direction.y = 1
	velocity = direction.normalized() * move_speed
	position += velocity * delta

	shoot()
	
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	#print("outside")
	queue_free()
	
func shoot():
	if canShoot:
		canShoot = false
		shoot_timer.start()
		audio_stream_player_2d.play()

		var bullet = ENEMY_BULLET.instantiate()
		bullet.set_position(marker_2d.global_position)
		get_parent().add_child(bullet)

func _on_shoot_timer_timeout() -> void:
	canShoot = true

func get_damage(damage):
	health -= damage
	#print("Enemy Damage")
	if health <= 0:
		enemy_destruction.emit(points)
		queue_free()

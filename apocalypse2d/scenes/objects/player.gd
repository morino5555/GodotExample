extends CharacterBody2D

# シグナル（死亡:GameOver、エネミー停止）
signal destruction
signal enemy_stop

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shoot_point: Marker2D = $shootPoint
@onready var attack_collision: CollisionShape2D = $AttackArea/AttackCollision
@onready var hp_bar: ProgressBar = $bar/ProgressBar

# キャラ
@export_group("Players")
@export var Move_Speed := 100.0 # 移動スピード
@export var hp = 20 # HP

# マウス加速度
const Acceleration = 1400
const Mouse_Sensitivity = 5.0
# マウス摩擦度
const Friction = 1000
# Direction
var direction: Vector2
# 死亡
var isDeath = false
var deathTimer = 1.0
# 攻撃
# 0:パンチ、1:ハンマー、2:ピストル、3:ショットガン、4:マシンガン
var weapon_id = 0
var isAttack = false
var damagePoint = 1		# パンチ、ハンマー、相手への攻撃ダメージ
var preloadBullet_p = preload("res://scenes/objects/bullet_p.tscn")
var preloadBullet_s = preload("res://scenes/objects/bullet_s.tscn")
var preloadBullet_m = preload("res://scenes/objects/bullet_m.tscn")
var bulletWait : Array =[0.8, 0.8, 0.5, 0.4, 0.2]

func _ready() -> void:
	attack_collision.disabled = true
	hp_bar.max_value = hp
	
	#print(Global.levelData[1])
	#print(Global.levelData[1]["enemy"])

func _physics_process(delta: float) -> void:
	if hp <= 0:
		if !isDeath:
			animation_player.play("death")
	else :
		_move(delta)

func _move(delta: float) -> void:
	var right_stick_input = Input.get_vector("rightstic_left",  "rightstic_right", "rightstic_up", "rightstic_down")
	var movement = right_stick_input * Mouse_Sensitivity * delta

	if movement.length_squared() > 0: # Check if there's any input
		var new_mouse_position = get_global_mouse_position() + movement
		#Input.warp_mouse(new_mouse_position)
		get_viewport().warp_mouse(new_mouse_position)
		
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1

	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if direction:
		#velocity = direction.normalized() * Move_Speed
		velocity.x = move_toward(velocity.x, Move_Speed * direction.x, Acceleration * delta)
		velocity.y = move_toward(velocity.y, Move_Speed * direction.y, Acceleration * delta)
	else :
		#velocity = Vector2.ZERO
		velocity.x = move_toward(velocity.x, Move_Speed * direction.x, Friction * delta)
		velocity.y = move_toward(velocity.y, Move_Speed * direction.y, Friction * delta)

	_attack()
	
	_set_animation()

	move_and_slide()
	
func _set_animation():
	# 0:パンチ、1:ハンマー、2:ピストル、3:ショットガン、4:マシンガン
	if isAttack:
		match weapon_id:
			1: animation_player.play("bat-attack")
			2: animation_player.play("pgun-shoot")
			3: animation_player.play("sgun-shoot")
			4: animation_player.play("mgun-shoot")
			_: animation_player.play("punch")
	else :
		if velocity != Vector2.ZERO:
			match weapon_id:
				1: animation_player.play("bat-run")
				2: animation_player.play("pgun-run")
				3: animation_player.play("sgun-run")
				4: animation_player.play("mgun-run")
				_: animation_player.play("run")
		else :
			match weapon_id:
				1: animation_player.play("bat-idle")
				2: animation_player.play("pgun-idle")
				3: animation_player.play("sgun-idle")
				4: animation_player.play("mgun-idle")
				_: animation_player.play("idle")

func _attack():
	if Input.is_action_pressed("attack"):
		if isAttack: return
		
		isAttack = true
		
		# 0:パンチ、1:ハンマー、2:ピストル、3:ショットガン、4:マシンガン
		match weapon_id:
			2:
				var bullet_p = preloadBullet_p.instantiate()
				get_parent().add_child(bullet_p)
				bullet_p.global_position = shoot_point.global_position
				bullet_p.rotation = rotation
				await get_tree().create_timer(bulletWait[2]).timeout
			3:
				var bullet_s = preloadBullet_s.instantiate()
				get_parent().add_child(bullet_s)
				bullet_s.global_position = shoot_point.global_position
				bullet_s.rotation = rotation
				await get_tree().create_timer(bulletWait[3]).timeout
			4:
				var bullet_m = preloadBullet_m.instantiate()
				get_parent().add_child(bullet_m)
				bullet_m.global_position = shoot_point.global_position
				bullet_m.rotation = rotation
				await get_tree().create_timer(bulletWait[4]).timeout
			_:
				attack_collision.disabled = false
				await get_tree().create_timer(bulletWait[0]).timeout
				attack_collision.disabled = true

		isAttack = false

# 攻撃を受けた
func get_damage(damage):
	hp -= damage
	hp_bar.value = hp

# 武器を拾う
func get_pickup(get_weapon_id):
	weapon_id = get_weapon_id

# パンチ、ハンマー攻撃
func _on_attack_area_body_entered(body: Node2D) -> void:
	if body in get_tree().get_nodes_in_group("Enemy"):
		body.get_damage(damagePoint)

# 終了、GameOver
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		isDeath = true
		await get_tree().create_timer(deathTimer).timeout
		destruction.emit()
		enemy_stop.emit()
		queue_free()

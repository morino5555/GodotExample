extends CharacterBody2D

# 破壊時のシグナル
signal enemy_destruction(points)

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var attack_collision: CollisionShape2D = $AttackArea/AttackCollision
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var hp_bar: ProgressBar = $bar/HPBar
@onready var drop_marker: Marker2D = $DropMarker
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

# キャラ
@export_group("Enemys")
@export var Move_Speed := 5.0 # 移動スピード
@export var hp = 5 # HP
@export var damagePoint = 2 # 相手への攻撃ダメージ
@export var scorePoints = 1 # スコア

# Player
var Player = null
var PlayerDeath = false
# 攻撃
var isAttack = false
# 死亡
var isDeath = false
var deathTimer = 1.0
# Drop Weapon ID
var dropWeaponId = 0

# 0:パンチ、1:ハンマー、2:ピストル、3:ショットガン、4:マシンガン
var preloadBat = preload("res://scenes/objects/drop_bat.tscn")
var preloadPgun = preload("res://scenes/objects/drop_pgun.tscn")
var preloadSgun = preload("res://scenes/objects/drop_sgun.tscn")
var preloadMgun = preload("res://scenes/objects/drop_mgun.tscn")

func _ready() -> void:
	Player = get_tree().get_first_node_in_group("Player")
	Player.enemy_stop.connect(_on_enemy_stop)
	attack_collision.disabled = true
	hp_bar.max_value = hp
	# 乱数
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	dropWeaponId = rng.randi_range(0, 10)
	#print(dropWeaponId)

func _physics_process(delta: float) -> void:
	if hp <= 0:
		if !isDeath:
			attack_collision.disabled = true
			collision_shape_2d.disabled = true
			hp_bar.visible = false
			animation_player.play("death")
	else :
		if !PlayerDeath:
			_move(delta)

func _move(delta: float) -> void:
	look_at(Player.global_position)
	var direction = (Player.global_position - global_position).normalized()
	velocity = direction * Move_Speed
	
	if direction.x > 0:
		scale.y = 1
	elif direction.x < 0:
		scale.y = -1

	_attack()

	if isAttack:
		animation_player.play("attack")
	else :
		attack_collision.disabled = true
		if velocity != Vector2.ZERO:
			animation_player.play("walk")
		else :
			animation_player.play("idle")

	move_and_slide()

func _attack():
	if ray_cast_2d.is_colliding():
		if ray_cast_2d.get_collider().name == "Player":
			isAttack = true
			ray_cast_2d.enabled = false

			attack_collision.disabled = false
			await get_tree().create_timer(0.8).timeout

			isAttack = false
			ray_cast_2d.enabled = true

func get_damage(damage):
	hp -= damage
	hp_bar.value = hp

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		isDeath = true
		enemy_destruction.emit(scorePoints)
		await get_tree().create_timer(deathTimer).timeout
		_drop_weapon()
		queue_free()

# 攻撃
func _on_attack_area_body_entered(body: Node2D) -> void:
	if body in get_tree().get_nodes_in_group("Player"):
		body.get_damage(damagePoint)

# Drop
func _drop_weapon():
	match dropWeaponId:
		2:
			# ハンマー
			var dropW = preloadBat.instantiate()
			get_parent().add_child(dropW)
			dropW.global_position = drop_marker.global_position
		4:
			# ピストル
			var dropW = preloadSgun.instantiate()
			get_parent().add_child(dropW)
			dropW.global_position = drop_marker.global_position
		6:
			# ショットガン
			var dropW = preloadPgun.instantiate()
			get_parent().add_child(dropW)
			dropW.global_position = drop_marker.global_position
		8:
			# マシンガン
			var dropW = preloadMgun.instantiate()
			get_parent().add_child(dropW)
			dropW.global_position = drop_marker.global_position

func _on_enemy_stop():
	PlayerDeath = true

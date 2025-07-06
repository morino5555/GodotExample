extends Node2D

# ランダムエネミー
@export var enemies: Array[PackedScene] = []
@onready var enemy_node: Node2D = $EnemyNode
@onready var enemy_spawn_timer: Timer = $EnemySpawnTimer
@onready var game_over: Control = $CanvasLayer/GameOver

# スコアー
var score = 0
var hi_score : int
@onready var hud: Control = $CanvasLayer/HUD

func _ready() -> void:
	# マウスカーソルを消す
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	var player = get_tree().get_first_node_in_group("player")
	player.destruction.connect(_on_player_destruction)
	hi_score = 0
	hud.update_score(0)

func _process(delta: float) -> void:
	# ESCでマウスカーソルを出す
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_enemy_spawn_timer_timeout() -> void:
	var enemy = enemies.pick_random().instantiate()
	enemy.global_position = Vector2(randf_range(40, 440) , 50)
	enemy.enemy_destruction.connect(_on_enemy_destruction)
	enemy_node.add_child(enemy)

func _on_enemy_destruction(points):
	score += points
	if score > hi_score:
		hi_score = score
	hud.update_score(score)
	#prints("Score: ", score)

func _on_player_destruction():
	game_over.visible = true
	game_over.set_score(score)
	game_over.set_hi_score(hi_score)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	

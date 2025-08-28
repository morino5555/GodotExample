extends Node2D

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var day_night_cycle: Control = $CanvasLayer/DayNightCycle
@onready var canvas_modulate: CanvasModulate = $CanvasModulate

# Wall
@onready var wall_1: TileMapLayer = $Field/Wall1
@onready var wall_2: TileMapLayer = $Field/Wall2
@onready var wall_3: TileMapLayer = $Field/Wall3

# GameOver
var gameover_scene = "res://scenes/gameover.tscn"

# Level
var stageLevel = 1
var stageName = ""

# Spawn
var spawnCnt = 0
@onready var spawn_timer: Timer = $Spawn/spawnTimer
# Level1
@onready var spawn_marker_1: Marker2D = $Spawn/spawnMarker1
@onready var spawn_marker_2: Marker2D = $Spawn/spawnMarker2
# Level2
@onready var spawn_marker_3: Marker2D = $Spawn/spawnMarker3
@onready var spawn_marker_4: Marker2D = $Spawn/spawnMarker4
# Level3
@onready var spawn_marker_5: Marker2D = $Spawn/spawnMarker5
@onready var spawn_marker_6: Marker2D = $Spawn/spawnMarker6
@onready var spawn_marker_7: Marker2D = $Spawn/spawnMarker7
@onready var spawn_marker_8: Marker2D = $Spawn/spawnMarker8
# 乱数
var rng
# Enemy
var enemyId = 0
@export var enemies: Array[PackedScene] = []
# 0:Small,1:Big,2:Axe
#var preloadEnemySmall = preload("res://scenes/objects/enemy_small.tscn")
#var preloadEnemyBig = preload("res://scenes/objects/enemy_big.tscn")
#var preloadEnemyAxe = preload("res://scenes/objects/enemy_axe.tscn")

var score = 0
var day_score = 0

func _ready() -> void:
	canvas_layer.visible = true
	canvas_modulate.time_tick.connect(day_night_cycle.set_daytime)
	canvas_modulate.day_score.connect(_on_day_score)

	var player = get_tree().get_first_node_in_group("Player")
	player.destruction.connect(_on_player_destruction)
	
	stageLevel = Global.stage_lebel

	# Name
	if stageLevel == 2:
		stageName = "normal"
	elif stageLevel == 3:
		stageName = "hard"
	else :
		stageName = "easy"

	# Wall
	if stageLevel == 2:
		wall_1.enabled = false
		wall_1.visible = false
		wall_2.enabled = true
		wall_2.visible = true
		wall_3.enabled = false
		wall_3.visible = false
	elif stageLevel == 3:
		wall_1.enabled = false
		wall_1.visible = false
		wall_2.enabled = false
		wall_2.visible = false
		wall_3.enabled = true
		wall_3.visible = true
	else :
		wall_1.enabled = true
		wall_1.visible = true
		wall_2.enabled = false
		wall_2.visible = false
		wall_3.enabled = false
		wall_3.visible = false

	# Spawn
	if stageLevel == 2:
		spawn_timer.wait_time = 2.0
	elif stageLevel == 3:
		spawn_timer.wait_time = 1.0
	else :
		spawn_timer.wait_time = 3.0
	# 乱数
	rng = RandomNumberGenerator.new()
	rng.randomize()
	spawn_timer.start()

func _process(delta: float) -> void:
	pass

func _on_spawn_timer_timeout() -> void:
	#var spawnEnemy
	#match enemyId:
	#	0: spawnEnemy = preloadEnemySmall.instantiate()
	#	1: spawnEnemy = preloadEnemyAxe.instantiate()
	#	2: spawnEnemy = preloadEnemyBig.instantiate()
	var spawnEnemy = enemies.pick_random().instantiate()
	spawnEnemy.enemy_destruction.connect(_on_enemy_destruction)
	get_parent().add_child(spawnEnemy)
	
	var spawnMarkId
	if stageLevel == 2:
		spawnMarkId = rng.randi_range(1, 4)
	elif stageLevel == 3:
		spawnMarkId = rng.randi_range(1, 8)
	else :
		spawnMarkId = rng.randi_range(1, 2)
	#print(spawnMarkId)
	match spawnMarkId:
		1: spawnEnemy.global_position = spawn_marker_1.global_position
		2: spawnEnemy.global_position = spawn_marker_2.global_position
		3: spawnEnemy.global_position = spawn_marker_3.global_position
		4: spawnEnemy.global_position = spawn_marker_4.global_position
		5: spawnEnemy.global_position = spawn_marker_5.global_position
		6: spawnEnemy.global_position = spawn_marker_6.global_position
		7: spawnEnemy.global_position = spawn_marker_7.global_position
		8: spawnEnemy.global_position = spawn_marker_8.global_position
	spawnCnt += 1
	enemyId = rng.randi_range(0, 2)

func _on_enemy_destruction(points):
	score += points

func _on_player_destruction():
	spawn_timer.stop()
	_save_score_data()
	Global.save_game()
	Global.goto_scene(gameover_scene)

func _save_score_data():
	# saveDatas {"level":"easy", "day":"day10", "point":"500,000"},
	# スコアに日数の10倍を掛けてスコアにする
	var s_score = score * ( day_score * 10)
	var dataLine = {
		"level" : stageName,
		"day" : "day" + str(day_score),
		"point" : str(s_score)
	}
	var datas = Global.saveDatas
	var isSave = false
	for i in range(3):
		print(i)
		if Global.saveDatas[i]["point"] != "":
			if  int(Global.saveDatas[i]["point"]) < s_score and !isSave:
				datas.insert(i, dataLine)
				isSave = true
				print("BB1")
		elif !isSave:
			datas.insert(i, dataLine)
			isSave = true
			print("BB2")
	Global.saveDatas = datas

func _on_day_score(day):
	day_score = day + 1
	

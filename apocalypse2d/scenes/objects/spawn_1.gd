extends StaticBody2D

@onready var spawn_marker: Marker2D = $SpawnMarker
@onready var spawn_timer: Timer = $SpawnTimer

# 生成
var spawnWaitTime = 3.0
var spawnMax = 10
var spawnCnt = 0

# 乱数
var rng
# Enemy
var enemyId = 0
# 0:Small,1:Big,2:Axe
var preloadEnemySmall = preload("res://scenes/objects/enemy_small.tscn")
var preloadEnemyBig = preload("res://scenes/objects/enemy_big.tscn")
var preloadEnemyAxe = preload("res://scenes/objects/enemy_axe.tscn")

func _ready() -> void:
	spawn_timer.wait_time = spawnWaitTime

	# 乱数
	rng = RandomNumberGenerator.new()
	rng.randomize()

	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	var spawnEnemy

	spawnCnt += 1
	if spawnCnt <= spawnMax:
		match enemyId:
			0:
				spawnEnemy = preloadEnemySmall.instantiate()
			1:
				spawnEnemy = preloadEnemyAxe.instantiate()
			2:
				spawnEnemy = preloadEnemyBig.instantiate()

		get_parent().add_child(spawnEnemy)
		spawnEnemy.global_position = spawn_marker.global_position

		enemyId = rng.randi_range(0, 2)
		#print(enemyId)

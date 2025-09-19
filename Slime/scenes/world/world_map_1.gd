extends Node2D

@onready var slime: AnimatedSprite2D = $Slime
@onready var levels: Node2D = $Levels

var markerLevels = []
@onready var currentMarker: Marker2D = $Levels/level_0

var lerp_speed = 0.01		# 移動スピード
var lerp_threshold = 0.1	# マーカーとキャラの移動しきい値
var movement = true			# 移動したか？

func _ready() -> void:
	markerLevels = levels.get_children()

func _process(delta: float) -> void:
	var targetMarker : Marker2D

	# レベル選択
	if Input.is_action_just_pressed("move_left"):
		if currentMarker.prev:
			targetMarker = currentMarker.prev
	if Input.is_action_just_pressed("move_right"):
		if currentMarker.next:
			targetMarker = currentMarker.next

	# 決定ボタン、ノード名がレベルになる
	if Input.is_action_just_pressed("jump"):
		prints("Selct Scene : ", currentMarker.name)
		#TransitionMgr.transition_to(scene_to_load, transition_speed_seconds, fade_sound)
		TransitionMgr.transition_to("res://scenes/world/level_1.tscn")

	# キャラ移動
	if targetMarker and movement:
		movement = false
		var lerp_progress = 0.0
		while  lerp_progress < 1.0:
			lerp_progress += lerp_speed + delta
			lerp_progress = clamp(lerp_progress, 0.0, 1.0)
			slime.position = slime.position.lerp(targetMarker.global_position, lerp_progress)
			
			if slime.position.distance_to(targetMarker.global_position) < lerp_threshold:
				break
			
			await get_tree().create_timer(delta).timeout
		slime.position = targetMarker.global_position
		currentMarker = targetMarker
		movement = true

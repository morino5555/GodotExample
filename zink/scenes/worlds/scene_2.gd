extends Node2D

@onready var start_point: Marker2D = $StartPoint

var player

func _ready() -> void:
	var player_load = preload("res://scenes/zink/zink.tscn")
	player = player_load.instantiate()
	player.transform.origin = start_point.global_position
	add_child(player)
	player.get_node("Camera").zoom = Vector2(2.0, 2.0)

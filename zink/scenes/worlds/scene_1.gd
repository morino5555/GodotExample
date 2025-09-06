extends Node2D

@onready var start_point: Marker2D = $StartPoint

var player

func _ready() -> void:
	var player_load = preload("res://scenes/zink/zink.tscn")
	player = player_load.instantiate()
	player.transform.origin = start_point.global_position
	add_child(player)

func _on_portal_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		TransitionMgr.transition_to("res://scenes/worlds/scene_2.tscn")

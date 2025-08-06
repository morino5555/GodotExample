extends Node3D

@onready var start_marker: Marker3D = $startMarker

var player

func _ready() -> void:
	var select_player = Global.get_player_character()
	player = select_player.instantiate()
	player.transform.origin = start_marker.global_position
	add_child(player)

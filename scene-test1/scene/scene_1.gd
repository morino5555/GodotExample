extends Node3D

var next_scene = preload("res://scene/scene_2.tscn")

@onready var start_marker: Marker3D = $startMarker
var player

func _ready() -> void:
	var select_player = Global.get_player_character()
	#player.global_position = start_marker.global_position
	player = select_player.instantiate()
	player.transform.origin = start_marker.global_position
	add_child(player)

func _on_signal_print(vallue):
	prints("signal:", vallue)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		#print("Player")
		#get_tree().change_scene_to_file.bind("res://scene/scene_2.tscn").call_deferred()
		get_tree().change_scene_to_packed.bind(next_scene).call_deferred()

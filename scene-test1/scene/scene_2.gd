extends Node3D

#var next_scene = load("res://scene/scene_1.tscn")
var next_scene = Global.s_1_path

@onready var start_marker: Marker3D = $startMarker
var player

func _ready() -> void:
	Global._player_character()
	player = Global.current_player.instantiate()
	player.transform.origin = start_marker.global_position
	add_child(player)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		#get_tree().change_scene_to_packed.bind(next_scene).call_deferred()
		Global.goto_scene(next_scene)

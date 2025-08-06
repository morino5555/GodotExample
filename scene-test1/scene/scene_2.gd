extends Node3D

var next_scene = load("res://scene/scene_1.tscn")

@onready var start_marker: Marker3D = $startMarker
var player

func _ready() -> void:
	pass
	var select_player = Global.get_player_character()
	player = select_player.instantiate()
	player.transform.origin = start_marker.global_position
	add_child(player)

func _on_area_3d_body_entered(body: Node3D) -> void:
	#print(body)
	if body.is_in_group("player"):
		get_tree().change_scene_to_packed.bind(next_scene).call_deferred()

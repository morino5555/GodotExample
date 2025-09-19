extends Node3D


func _on_transition_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		#print("player")
		#TransitionMgr.transition_to(scene_to_load, transition_speed_seconds, fade_sound)
		TransitionMgr.transition_to("res://scenes/worlds/level_2.tscn")

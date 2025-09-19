extends Node2D

func _on_dead_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		TransitionMgr.transition_to(get_tree().current_scene.scene_file_path)

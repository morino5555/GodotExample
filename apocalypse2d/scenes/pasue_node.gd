extends Node2D

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		get_viewport().set_input_as_handled()
		if get_tree().paused:
			get_tree().paused = false

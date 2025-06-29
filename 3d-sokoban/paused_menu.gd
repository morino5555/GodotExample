extends Control

var _is_paused: bool = false:
	set = set_paused

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_is_paused = !_is_paused

func set_paused(value: bool):
	_is_paused = value
	get_tree().paused = _is_paused
	visible = _is_paused

func _on_resume_btn_pressed() -> void:
	_is_paused = false

func _on_restart_btn_pressed() -> void:
	_is_paused = false
	get_tree().reload_current_scene()
	#get_tree().change_scene_to_file("res://level_1.tscn")

func _on_quit_btn_pressed() -> void:
	get_tree().quit()

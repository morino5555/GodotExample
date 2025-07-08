extends Node2D

func _on_stage_1_button_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/stage_1.tscn")
	SceneSwitcher.switch_scene("res://scenes/stage_1.tscn")

func _on_stage_2_button_pressed() -> void:
	SceneSwitcher.switch_scene("res://scenes/stage_2.tscn")

func _on_menu_button_pressed() -> void:
	SceneSwitcher.switch_scene("res://scenes/option_menu.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

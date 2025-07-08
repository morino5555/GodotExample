extends Control

func _on_menu_button_pressed() -> void:
	SceneSwitcher.switch_scene("res://scenes/option_menu.tscn")

func _on_start_button_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/game.tscn")
	SceneSwitcher.switch_scene("res://scenes/game.tscn")

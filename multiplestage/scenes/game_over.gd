extends Control

@onready var menu_button: Button = $ColorRect/MenuButton
@onready var restart_button: Button = $ColorRect/RestartButton

func _on_menu_button_pressed() -> void:
	SceneSwitcher.switch_scene("res://scenes/option_menu.tscn")

func _on_restart_button_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/game.tscn")
	SceneSwitcher.switch_scene("res://scenes/game.tscn")
	

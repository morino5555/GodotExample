extends Control

@onready var hiscore_label: Label = $Panel/HiscoreLabel
@onready var score_label: Label = $Panel/ScoreLabel

func set_score(score):
	score_label.text = "Score : " + str(score)

func set_hi_score(score):
	hiscore_label.text = "Hi-Score : " + str(score)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()

extends CanvasLayer

# 次のシーン
var next_scene = "res://scenes/test_1.tscn"

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_easy_button_pressed() -> void:
	Global.stage_lebel = 1
	Global.goto_scene(next_scene)

func _on_normal_button_pressed() -> void:
	Global.stage_lebel = 2
	Global.goto_scene(next_scene)

func _on_hard_button_pressed() -> void:
	Global.stage_lebel = 3
	Global.goto_scene(next_scene)

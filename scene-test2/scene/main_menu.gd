extends CanvasLayer

var next_scene = "res://scene/scene_1.tscn"
#var next_scene = Global.s_1_path

func _on_character_1_button_pressed() -> void:
	Global.current_player_select = "barbarian"
	Global.goto_scene(next_scene)

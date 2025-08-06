extends CanvasLayer

var next_scene = preload("res://scene/scene_1.tscn")

func _on_character_1_button_pressed() -> void:
	Global.player_chatacter = "barbarian"
	#get_tree().change_scene_to_file("res://scene/scene_1.tscn")
	get_tree().change_scene_to_packed(next_scene)

func _on_character_2_button_pressed() -> void:
	Global.player_chatacter = "knight"
	#get_tree().change_scene_to_file("res://scene/scene_1.tscn")
	get_tree().change_scene_to_packed(next_scene)

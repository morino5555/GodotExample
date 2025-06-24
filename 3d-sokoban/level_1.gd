extends Node3D

@onready var paused_menu: Control = $PausedMenu
@onready var paused_label: Label = $PausedMenu/GridContainer/Label
@onready var paused_resume_btn: Button = $PausedMenu/GridContainer/ResumeBtn

func _process(_delta: float) -> void:
	var goals = $Goals.get_child_count()
	for g in $Goals.get_children():
		if g.goaled:
			goals -= 1

	if goals == 0:
		paused_menu.set_paused(true)
		paused_resume_btn.visible = false
		paused_label.text = "Goal!!"
		#get_tree().change_scene_to_file("res://paused_menu.tscn")

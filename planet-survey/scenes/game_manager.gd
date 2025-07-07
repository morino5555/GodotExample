extends Node2D

@onready var score_label: Label = %scoreLabel
@onready var heart_parent: HBoxContainer = %heart

var score = 0
var heart = 3
var heart_list : Array[TextureRect]

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	score_label.text = "Score : " + str(score)
	for child in heart_parent.get_children():
		heart_list.append(child)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func add_coin():
	score += 1
	score_label.text = "Score : " + str(score)
	
func take_damage():
	if heart > 1:
		heart -= 1
		update_heart()
	else:
		get_tree().reload_current_scene()

func update_heart():
	for i in range(heart_list.size()):
		heart_list[i].visible = i < heart
		prints("i:",i, " H:", heart)
		

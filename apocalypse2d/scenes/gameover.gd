extends CanvasLayer

# シーン
var menu_scene = "res://scenes/main_menu.tscn"
var next_scene = "res://scenes/test_1.tscn"

@onready var grid_container: GridContainer = $VBoxContainer/GridContainer
@onready var label_1: Label = $VBoxContainer/GridContainer/Label1
@onready var label_2: Label = $VBoxContainer/GridContainer/Label2
@onready var label_3: Label = $VBoxContainer/GridContainer/Label3
@onready var label_4: Label = $VBoxContainer/GridContainer/Label4
@onready var label_5: Label = $VBoxContainer/GridContainer/Label5
@onready var label_11: Label = $VBoxContainer/GridContainer/Label11
@onready var label_12: Label = $VBoxContainer/GridContainer/Label12
@onready var label_13: Label = $VBoxContainer/GridContainer/Label13
@onready var label_14: Label = $VBoxContainer/GridContainer/Label14
@onready var label_15: Label = $VBoxContainer/GridContainer/Label15
@onready var label_21: Label = $VBoxContainer/GridContainer/Label21
@onready var label_22: Label = $VBoxContainer/GridContainer/Label22
@onready var label_23: Label = $VBoxContainer/GridContainer/Label23
@onready var label_24: Label = $VBoxContainer/GridContainer/Label24
@onready var label_25: Label = $VBoxContainer/GridContainer/Label25

var gameData

func _ready() -> void:
	#Global.load_game()
	gameData = Global.saveDatas
	_grid_label()

func _grid_label():
	# {"level":"easy", "day":"day10", "point":"500,000"},
	# Row1
	label_1.text = "1"
	if gameData[0]["level"]:
		label_2.text = gameData[0]["level"]
	else :
		label_2.text = "-"
	if gameData[0]["day"]:
		label_3.text = gameData[0]["day"]
	else :
		label_3.text = "-"
	if gameData[0]["point"]:
		label_4.text = gameData[0]["point"]
		label_5.text = "p"
	else :
		label_4.text = "-"
		label_5.text = ""
	# Row2
	label_11.text = "2"
	if gameData[1]["level"]:
		label_12.text = gameData[1]["level"]
	else :
		label_12.text = "-"
	if gameData[1]["day"]:
		label_13.text = gameData[1]["day"]
	else :
		label_13.text = "-"
	if gameData[1]["point"]:
		label_14.text = gameData[1]["point"]
		label_15.text = "p"
	else :
		label_14.text = "-"
		label_15.text = ""
	# Row3
	label_21.text = "3"
	if gameData[2]["level"]:
		label_22.text = gameData[2]["level"]
	else :
		label_22.text = "-"
	if gameData[2]["day"]:
		label_23.text = gameData[2]["day"]
	else :
		label_23.text = "-"
	if gameData[2]["point"]:
		label_24.text = gameData[2]["point"]
		label_25.text = "p"
	else :
		label_24.text = "-"
		label_25.text = ""

func _on_restart_button_pressed() -> void:
	Global.stage_lebel = 1
	Global.goto_scene(next_scene)

func _on_menu_button_pressed() -> void:
	Global.stage_lebel = 1
	Global.goto_scene(menu_scene)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

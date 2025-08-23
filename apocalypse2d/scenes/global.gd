extends Node

@onready var color_rect: ColorRect = $CanvasLayer/ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const SAVE_PATH = "res://savegame.bin"

var current_scene = null

var stage_lebel = 1

# SaveData
# {"level":"easy", "day":"day10", "point":"500,000"},
#var saveDatas = []
var saveDatas = [
	{"level":"", "day":"", "point":""},
	{"level":"", "day":"", "point":""},
	{"level":"", "day":"", "point":""},
]

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(-1)
	# マウスカーソル非表示
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	load_game()

func _input(event: InputEvent) -> void:
	# マウスカーソル表示
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

# シーンチェンジ
func goto_scene(path):
	_deferred_goto_scene.call_deferred(path)

func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	color_rect.visible = true
	animation_player.play("fade")
	await animation_player.animation_finished
	color_rect.visible = false

# データ保存（JSON形式）
func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var saveData: Dictionary = {
		"saveDatas": saveDatas
	}
	var jsonString = JSON.stringify(saveData)
	file.store_line(jsonString)
	print("SAVE")

# データ読込（JSON形式）
func load_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH):
		var data = JSON.parse_string(file.get_line())
		saveDatas = data["saveDatas"]
	#else:
	#	print("No Data")

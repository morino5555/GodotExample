extends Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect

var current_scene = null
var current_player_select: String = "barbarian"
var current_player: PackedScene

var s_1_path = "res://scene/scene_1.tscn"
var s_2_path = "res://scene/scene_2.tscn"

var p_1_path = "res://barbarian/barbarian.tscn"
var p_2_path = "res://knight/knight.tscn"

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(-1)
	# マウスカーソル非表示
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	# マウスカーソル表示
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

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

func _player_character():
	match current_player_select:
		"barbarian":
			current_player = load(p_1_path)
			#current_player = preload("res://barbarian/barbarian.tscn")
		"knight":
			current_player = load(p_2_path)
			#current_player = preload("res://knight/knight.tscn")

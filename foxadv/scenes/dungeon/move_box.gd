extends Node3D

# 箱が移動した
# move_box -> level3
signal box_ok

@onready var move_box_small: CharacterBody3D = $move_box_small
@onready var move_box_small_line: Node3D = $move_box_small_line
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var isAnimation = false

func _ready() -> void:
	isAnimation = true

func _physics_process(delta: float) -> void:
	if isAnimation:
		animation_player.play("blink")

func _on_move_box_small_move_box_end() -> void:
	print("signal")
	animation_player.stop()
	isAnimation = false
	box_ok.emit()

extends Node3D

# 箱が入ったのでチェストを開ける
# level3 -> chest
signal chest_open

var box_ok = 0
var isOpen = true

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if box_ok >= 3 and isOpen:
		chest_open.emit()
		isOpen = false

func _on_move_box_box_ok() -> void:
	print("BOX1")
	box_ok += 1

func _on_move_box_2_box_ok() -> void:
	print("BOX2")
	box_ok += 1

func _on_move_box_3_box_ok() -> void:
	print("BOX3")
	box_ok += 1

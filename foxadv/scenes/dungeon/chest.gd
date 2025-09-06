extends CharacterBody3D

# チェストをオープンしてキーを出す
# chest -> key
signal chestOpen

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.stop()

func chest_open():
	animation_player.play("open")
	chestOpen.emit()

func chest_close():
	animation_player.play("close")

func _on_level_3_chest_open() -> void:
	print("Chest")
	chest_open()

func _on_key_key_player() -> void:
	print("Close")
	chest_close()

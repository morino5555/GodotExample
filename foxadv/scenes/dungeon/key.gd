extends Area3D

# キーをプレイヤーが取った
# key -> chest
signal keyPlayer

@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

func _ready() -> void:
	collision_shape_3d.disabled = true

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		keyPlayer.emit()
		EventBus.playerKeyGet.emit()
		queue_free()

func _on_chest_chest_open() -> void:
	collision_shape_3d.disabled = false

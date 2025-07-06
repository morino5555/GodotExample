extends Area2D

# 移動スピード
const move_speed = 200.0
# バレットダメージ
var damage = 1

var direction = 1

func _ready() -> void:
	await get_tree().create_timer(3).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	position.y += direction * move_speed * delta
	


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.get_damage(damage)
		queue_free()

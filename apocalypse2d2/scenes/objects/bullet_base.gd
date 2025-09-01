extends Area2D

# 弾
@export_group("Bullets")
@export var Move_Speed := 100.0 # 移動スピード
@export var damagePoint = 2 # 相手へのダメージ

func _process(delta: float) -> void:
	position += transform.x * Move_Speed * delta

# 画面の範囲外の処理
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

# 弾が当たった
func _on_body_entered(body: Node2D) -> void:
	#if body.name == "Enemy":
	if body in get_tree().get_nodes_in_group("Enemy"):
		body.get_damage(damagePoint)

	queue_free()

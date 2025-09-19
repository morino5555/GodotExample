extends Area2D

var health = 30.0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.take_heal(health)
		queue_free()

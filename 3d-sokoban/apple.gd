extends Area3D

var goaled = false

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Box"):
		goaled = true

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("Box"):
		goaled = false

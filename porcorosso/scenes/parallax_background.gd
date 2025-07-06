extends ParallaxBackground

func _process(delta: float) -> void:
	scroll_base_offset += Vector2(0, 50) * delta

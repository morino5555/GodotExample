extends RichTextLabel

var scroll_speed = 15
var max_position_y = -500

func _process(delta):
	position.y -= scroll_speed * delta
	if position.y < max_position_y:
		position.y = 0.0

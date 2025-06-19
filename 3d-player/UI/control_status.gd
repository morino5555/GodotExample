extends Control

func _input(event):
	#print(event)

	if event is InputEventKey:
		if (event.as_text() == "W" or event.as_text() == "A" or event.as_text() == "S" or event.as_text() == "D"
		or 
		event.as_text() == "Space"
		or
		event.as_text() == "Up" or event.as_text() == "Down" or event.as_text() == "Left" or event.as_text() == "Right"):
			if event.pressed:
				get_node(event.as_text()).color = Color("ff6666")
			else :
				get_node(event.as_text()).color = Color("ffffff")

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			$Mouse_Left.color = Color("ff6666")
		else :
			$Mouse_Left.color = Color("ffffff")
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			$Mouse_Right.color = Color("ff6666")
		else :
			$Mouse_Right.color = Color("ffffff")

	if event is InputEventMouseMotion:
		$Mouse.color = Color("ff6666")
	else :
		$Mouse.color = Color("ffffff")
		

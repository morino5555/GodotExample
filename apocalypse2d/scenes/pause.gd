extends Control

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		resume()

func resume():
	get_viewport().set_input_as_handled()
	self.visible = false
	get_tree().paused = false
	
func pause():
	self.visible = true
	get_tree().paused = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_back_button_pressed() -> void:
	resume()

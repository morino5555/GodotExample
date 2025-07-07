extends Area2D

@onready var timer: Timer = $Timer
@onready var game_manager: Node2D = %GameManager

func _on_body_entered(body: Node2D) -> void:
	#get_tree().reload_current_scene()
	timer.start()

func _on_timer_timeout() -> void:
	get_tree().current_scene
	

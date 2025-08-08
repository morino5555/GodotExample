extends "res://scene/base_character.gd"

func _attack(delta: float):
	if Input.is_action_pressed("attack"):
		state_machine.travel("2H_Attack_Chop")

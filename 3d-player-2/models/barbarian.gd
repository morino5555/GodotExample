class_name BarbarianSkin extends Node3D

#@onready var animation_tree: AnimationTree = %AnimationTree
#@onready var state_machine : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback")
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func idle():
	#state_machine.travel("Idle")
	animation_player.play("Idle")

func move():
	#state_machine.travel("Walking_C")
	animation_player.play("Walking_C")

func jump():
	#state_machine.travel("Jump_Full_Short")
	animation_player.play("Jump_Full_Short")

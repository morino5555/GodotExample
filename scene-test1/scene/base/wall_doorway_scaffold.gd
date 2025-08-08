extends StaticBody3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label_3d: Label3D = $Label3D

var opened = false
var inRange = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interaction") && !opened && inRange:
		opened = true
		label_3d.visible = false
		animation_player.play("open")

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		label_3d.visible = true
		inRange = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		label_3d.visible = false
		inRange = false
		if opened:
			animation_player.play("close")
			opened = false
		

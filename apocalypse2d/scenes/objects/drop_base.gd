extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Weapons
# 0:パンチ、1:ハンマー、2:ピストル、3:ショットガン、4:マシンガン
@export_group("Weapons")
@export var weapon_id = 1 # 武器ID

func _physics_process(delta: float) -> void:
	animation_player.play("blink")

func _on_body_entered(body: Node2D) -> void:
	if body in get_tree().get_nodes_in_group("Player"):
		body.get_pickup(weapon_id)
		#await get_tree().create_timer(0.3).timeout
		queue_free()

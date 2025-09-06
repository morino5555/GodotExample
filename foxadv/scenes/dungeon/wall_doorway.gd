extends StaticBody3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var isKey = false

func _ready() -> void:
	isKey = false
	EventBus.playerKeyGet.connect(_on_player_key_get)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		print("player")
		if isKey:
			animation_player.play("open")
			isKey = false

func _on_player_key_get():
	print("KeyGet")
	isKey = true

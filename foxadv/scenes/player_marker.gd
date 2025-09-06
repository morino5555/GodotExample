extends Marker3D

var playerPreload = preload("res://scenes/fox/fox.tscn")
var player

func _ready() -> void:
	player = playerPreload.instantiate()
	#player.transform.origin = global_position
	add_child(player)
	

class_name Box extends CharacterBody3D

var grid_size = 2.0

@onready var ray_cast_3d: RayCast3D = $RayCast3D

func _ready() -> void:
	position = position.snapped(Vector3(1, 0, 1) * grid_size)

func box_can_move(dir):
	ray_cast_3d.target_position = dir
	ray_cast_3d.force_raycast_update()
	return !ray_cast_3d.is_colliding()

func box_move(dir):
	position += dir

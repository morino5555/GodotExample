extends CharacterBody3D

var grid_size = 2.0

var inputs = {"move_left": Vector3.LEFT, "move_right": Vector3.RIGHT, "move_forward": Vector3.FORWARD, "move_back": Vector3.BACK}

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var cow_vox: MeshInstance3D = $Cow_vox

var move_position: Vector3 = Vector3.ZERO
#var target_position: Vector3 = Vector3.ZERO

func _ready() -> void:
	position = position.snapped(Vector3(1, 0, 1) * grid_size)

func _input(event: InputEvent) -> void:
	move_position = position

	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			check_and_move(dir)

func check_and_move(dir):
	move_position += inputs[dir] * grid_size

	var target_position = move_position - position
	ray_cast_3d.target_position = target_position
	ray_cast_3d.force_raycast_update()
	if !ray_cast_3d.is_colliding():
		move(move_position, target_position)
	else :
		var ray_collider = ray_cast_3d.get_collider()
		#const Box = preload("res://box_1.gd")
		#if ray_collider is Box:
		if ray_collider.is_in_group("Box"):
			if ray_collider.box_can_move(target_position):
				ray_collider.box_move(target_position)
				move(move_position, target_position)

func move(move_pos, target_pos):
	position = move_pos
	cow_vox.rotation.y = atan2(target_pos.x, target_pos.z)

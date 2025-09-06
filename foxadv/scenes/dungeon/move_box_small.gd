extends CharacterBody3D

# 箱が所定の位置に入った
# move_box_small -> move_box
signal move_box_end

@export_group("Movement")
@export var move_speed := 5.0 # スピード
@export var check_distance := 5.0 # 移動距離

var isPush = false
var s_pos
var e_pos
var move_direction = Vector3(0,0,1)

func _ready() -> void:
	isPush = false
	s_pos = global_transform.origin

func _physics_process(delta: float) -> void:
	if isPush:
		global_transform.origin += global_transform.basis * move_direction * move_speed * delta
		e_pos = global_transform.origin
		var distance = s_pos.distance_to(e_pos)
		if distance > check_distance:
			move_direction = Vector3.ZERO
			isPush = false
			move_box_end.emit()

	move_and_slide()

func fox_push():
	isPush = true

extends Node3D

@export var offset := Vector3.UP
@export var fon_size := 50
@export var labelRange := 2
@export var animationDuration := 2

const INDCATER_LABEL = preload("res://scenes/indcater/indcater_label.tscn")

func create_Indicator_label(value):
	var indicatorLabel = INDCATER_LABEL.instantiate()
	indicatorLabel.set_value(value)
	
	get_tree().current_scene.add_child(indicatorLabel)
	#indicatorLabel.global_position = global_position * offset
	indicatorLabel.global_position = global_position

	_tween_indikator(indicatorLabel)
	
func _tween_indikator(label):
	var tween = create_tween()
	var randomTargetPosition = Vector3(
		randf_range(-labelRange, labelRange),
		randf_range(-labelRange, labelRange),
		randf_range(-labelRange, labelRange)
	)
	
	tween.tween_property(label, "position", label.global_position + randomTargetPosition, animationDuration)
	tween.tween_callback(label.queue_free)
	

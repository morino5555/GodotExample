extends Node3D

var next_scene = "res://scene/scene_2.tscn"
#var next_scene = Global.s_2_path

@onready var start_marker: Marker3D = $startMarker
var player

var player_camera:Camera3D
@onready var camera_3d: Camera3D = $Camera3D
	
func _ready() -> void:
	Global._player_character()
	player = Global.current_player.instantiate()
	player.transform.origin = start_marker.global_position
	add_child(player)
	
	#print(player.get_child(0))
	#print(player.get_node("CameraPivot/SpringArm3D/Camera3D"))
	#print(player.get_node("CameraPivot").get_child(0).get_child(0))
	player_camera = player.get_node("CameraPivot").get_child(0).get_child(0)
	player_camera.current = false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		#get_tree().change_scene_to_packed.bind(next_scene).call_deferred()
		Global.goto_scene(next_scene)
		
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("cam_change"):
		camera_3d.current = true
		#camera_3d.look_at(player.global_position)
		camera_3d.look_at(player.global_transform.origin)
	elif Input.is_action_pressed("cam_change2"):
		player_camera.current = true

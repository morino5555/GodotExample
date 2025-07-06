extends Area2D

# 移動スピード
const move_speed = 300.0
# プレーヤーからの距離
const bullet_range = 500.0
# バレットダメージ
var damage = 1

var direction = -1

func _ready() -> void:
	await get_tree().create_timer(3).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	position.y += direction * move_speed * delta
	
	#　プレーヤーから指定距離離れたら消す
	var player = get_tree().get_first_node_in_group("player")
	if player:
		var distance = global_position.distance_to(player.global_position)
		if distance > bullet_range:
			queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.get_damage(damage)
		queue_free()

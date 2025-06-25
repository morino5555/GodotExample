extends Button

@export_group("Abirity")
@export var dispaly_name: StringName
@export var mana_cost: int = 0
@export var damage: float = 0

func _ready() -> void:
	var event: InputEvent = shortcut.events[0]
	text = event.as_text()
	pressed.connect(_on_pressed)

func _on_pressed():
	prints("Name:", dispaly_name, " / Mana:",mana_cost, " / ", damage)
	

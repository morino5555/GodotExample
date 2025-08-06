extends Node

var player_chatacter: String
var player: PackedScene

func set_player_character(player_character):
	self.player_chatacter = player_character
	
func get_player_character():
	match player_chatacter:
		"barbarian":
			player = preload("res://barbarian/barbarian.tscn")
		"knight":
			player = preload("res://knight/knight.tscn")
		_:
			player = preload("res://barbarian/barbarian.tscn")

	return player
	

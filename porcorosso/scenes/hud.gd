extends Control

@onready var score_label: Label = $scoreLabel

func update_score(score):
	score_label.text = "Score : " + str(score)

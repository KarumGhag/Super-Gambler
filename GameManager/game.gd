extends Node2D

class_name Game

@export var better : BetManager

func win() -> void:
	better.win(true)

func lose() -> void:
	better.lose(false)

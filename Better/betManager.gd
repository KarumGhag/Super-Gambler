extends Node2D

class_name BetManager

var betAmount : int

func addBet(value) -> void:
	betAmount += value

func takeBet(value) -> void:
	if betAmount - value < 0:
		betAmount = 0
		return
	betAmount -= value

func _process(_delta) -> void:
	print(betAmount)
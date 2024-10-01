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

@export var game : Game

@onready var moneySystem = get_node("/root/MoneySystem")

func win() -> void:
	moneySystem.win(betAmount)

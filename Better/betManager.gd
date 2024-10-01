extends Node2D

class_name BetManager

var betAmount : int = 0

func addBet(value) -> void:
	betAmount += value
	updateLabel()

func takeBet(value) -> void:
	if betAmount - value < 0:
		betAmount = 0
		return
	betAmount -= value
	updateLabel()

@export var game : Game

@onready var moneySystem = get_node("/root/MoneySystem")

func win(won : bool) -> void:
	moneySystem.changeMoney(betAmount)
	betAmount = 0
	print(betAmount)
	updateLabel()

func lose(_test):
	pass

@export var amountBetLabel : Label

func _ready():
	updateLabel()

func updateLabel() -> void:
	amountBetLabel.text = "Amount bet : £" + str(betAmount)

@export var mouse : Area2D

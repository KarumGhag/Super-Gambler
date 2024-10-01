extends Node

class_name MoneyManager

var money : float = 500

func changeMoney(betAmount : int) -> void:
	money += betAmount * 2
	print("won")
	print(money)
	updateLabel()

@export var moneyCounter : Label

func _ready():
	updateLabel()

func updateLabel() -> void:
	moneyCounter.text = "£" + str(money)

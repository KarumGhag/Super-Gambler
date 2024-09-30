extends Node

class_name GameManager

@export var betManager : BetManager
var bet : int
var winAmount : int

@export var moneyManager : MoneyManager

func win() -> void:
	bet = betManager.betAmount
	winAmount = bet * 2
	moneyManager.money += winAmount

func lose() -> void:
	bet = betManager.betAmount
	winAmount = -bet
	moneyManager.money += winAmount
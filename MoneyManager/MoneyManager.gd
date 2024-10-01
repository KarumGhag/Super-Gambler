extends Node

class_name MoneyManager

var money : float = 0

func win(winnings) -> void:
    money += winnings

func lose(lossAmount) -> void:
    money -= lossAmount
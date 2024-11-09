extends Node2D

class_name BlackJack

@export var hitButton : Button
@export var card : Sprite2D
@export var deck : Deck

var cardImages : Array = []
var cardValues : Array = []

var shuffleReturn = []

var values : Array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10]

var i = 0

func _ready():
	hitButton.connect("button_down", hit)

	shuffleReturn = deck.shuffler(values)
	cardImages = shuffleReturn[0]
	cardValues = shuffleReturn[1]

	print(cardImages, cardValues)

func hit():
	card.texture = cardImages[i].texture
	print(values[i])
	print(i)
	i += 1
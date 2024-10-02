extends Node2D

class_name BlackJackManager

@export var hitButton : Button
@export var standButton : Button

@export var deckManager : Deck
var deck : Array

var dealerCards : Array
var playerCards : Array

var dealerValue : int = 0
var playerValue : int = 0

var hasStood : bool = false

func _ready():

	hitButton.connect("button_down", hit)
	standButton.connect("button_down", stand)

	#TEMPORARY
	newGame()


func newGame() -> void:
	hasStood = false
	deckManager.cardValues = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]
	deckManager.cardValues.shuffle()
	
	deck = deckManager.cardValues

	playerCards = []
	playerValue = 0
	dealerCards = []
	dealerValue = 0

	dealerCards = getFirst2()
	dealerValue = getValue(dealerCards)

	playerCards = getFirst2()
	playerValue = getValue(playerCards)

	print(playerCards, playerValue)
	print(dealerCards, dealerValue)



func getFirst2() -> Array:
	var cards : Array = []

	#adds first 2 cards in the deck to a temp value
	cards.append(deck[0])
	cards.append(deck[1])

	#makes a temp store of the deck
	var tempDeck : Array = deck

	#resets deck
	deck = []
	
	#adds all cards from temp deck to new deck except first 2 (were added to the hand)
	for i in range(len(tempDeck)):
		if i == 0 or i == 1:
			continue
		deck.append(tempDeck[i])
	return cards


func getValue(cards : Array) -> int:
	var value : int = 0

	for i in range(len(cards)):
		value += cards[i]

	return value



func hit() -> void:
	if hasStood:
		return
	playerCards.append(deck[0])
	midGameReset()


	playerValue = getValue(playerCards)
	print(playerCards, playerValue)

	if playerValue > 21:
		print("bust")
		newGame()

func stand() -> void:
	hasStood = true

func midGameReset() -> void:
	#makes a temp store of the deck
	var tempDeck : Array = deck

	#resets deck
	deck = []
	
	#adds all cards from temp deck to new deck except first 2 (were added to the hand)
	for i in range(len(tempDeck)):
		if i == 0:
			continue
		deck.append(tempDeck[i])




func cantHitCheck() -> bool:
	var value : int = 0

	value = getValue(dealerCards)
	if value < 17:
		return false
	else:
		return true


func bust() -> void:
	print("Bust")
	newGame()
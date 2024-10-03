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

@export var deckLabel : Label
@export var playerLabel : Label
@export var dealerLabel : Label
@export var deckLen : Label
@export var message : Label

var inGame : bool = false
@export var newGameButton : Button

func _ready():

	hitButton.connect("button_down", hit)
	standButton.connect("button_down", stand)
	newGameButton.connect("button_down", newGame)

	#TEMPORARY
	deckManager.cardValues.shuffle()
	deck = deckManager.cardValues
	newGame()
	
	
	


func newGame() -> void:
	if inGame:
		print("in game")
		return
	hasStood = false
	
	#deckManager.cardValues = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]
	
	
	
	
	#print(len(deck))

	playerCards = []
	playerValue = 0
	dealerCards = []
	dealerValue = 0

	dealerCards = getFirst2()
	dealerValue = getValue(dealerCards)

	playerCards = getFirst2()
	playerValue = getValue(playerCards)

	#print(playerCards, playerValue)
	#print(dealerCards, dealerValue)



func getFirst2() -> Array:
	inGame = true
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
	if hasStood or not inGame:
		return
	playerCards.append(deck[0])
	midGameReset()


	playerValue = getValue(playerCards)
	#print(playerCards, playerValue)

	if playerValue > 21:
		#print("bust")
		cardsToBottom(playerCards, dealerCards)
		inGame = false


func stand() -> void:
	if not inGame:
		return
	hasStood = true
	showDealerCard()

	if dealerValue > playerValue:
		#print("dealer higher")
		cardsToBottom(playerCards, dealerCards)
		inGame = false
		return
	
	while true:
		dealerCards.append(deck[0])
		midGameReset()
		dealerValue = getValue(dealerCards)

		#dealer bust
		if dealerValue > 21:
			message.text = "dealer bust"
			cardsToBottom(playerCards, dealerCards)
			inGame = false
			return

		#dealer has higher number and wins
		if dealerValue > playerValue:
			message.text = "dealer has higher number"
			cardsToBottom(playerCards, dealerCards)
			inGame = false
			return
		
		#dealer cant hit over 17
		if dealerValue >= 17:
			break
	
	#player wins - they have higher number
	if dealerValue < playerValue and dealerValue >= 17:
		message.text = "player has higher number"
		cardsToBottom(playerCards, dealerCards)
		inGame = false
		return
	
	#draw
	if dealerValue == playerValue:
		message.text = "draw"
		cardsToBottom(playerCards, dealerCards)
		inGame = false
		return
	
		


func showDealerCard() -> void:
	#will flip dealer card
	pass

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

func cardsToBottom(player : Array, dealer : Array) -> void:
	for i in range(len(player)):
		deck.append(player[i])
	for i in range(len(dealer)):
		deck.append(dealer[i])

	playerCards = []
	dealerCards = []

func _process(_delta) -> void:
	playerLabel.text = "Player : " + str(playerValue) + str(playerCards)
	dealerLabel.text = "Dealer : " + str(dealerValue) + str(dealerCards)
	deckLabel.text = "Deck : " + str(deck)
	deckLen.text = "Len : " + str(len(deck))

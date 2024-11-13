extends Node2D

class_name BlackJack

@export var hitButton : Button
@export var standButton : Button
var hasStood : bool = false
@export var deck : Deck

var cardImages : Array = []
var cardValues : Array = []

var shuffleReturn = []

var values : Array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10]

var nextCardPos : int = 0

var nextTexture : Texture
var nextValue : int
var playerTotal : int = 0
var dealerTotal : int = 0

@export var playerLabel : Label
@export var dealerLabel : Label

var madeCards : bool = true
var gameOver : bool = true

var red : Color = Color(255, 0, 0)
var green : Color = Color(0, 255, 0)

@export var newGameButton : Button

var winMessage : String = "You won!"

func _ready() -> void:
	hitButton.connect("button_down", playerHit)
	standButton.connect("button_down", stand)
	newGameButton.connect("button_down", newGame)

	#shuffles and gets the cards and values
	shuffleReturn = deck.shuffler(values)
	cardImages = shuffleReturn[0]
	cardValues = shuffleReturn[1]

	resetCards()



func playerHit() -> void:
	hit(false)


func stand() -> void:
	hasStood = true

	hit(true)
	print("stand")


func hit(dealer : bool) -> void:

	#this means the dealer is trying to hit, you have stood and the dealer cannot hit (their card value is above 16)
	if dealer and hasStood and not dealerHitCheck():
		checkWinner()
		return

	
	if not dealer and hasStood:
		print("cannot hit after standing!")
		return

	#gets the texture of the next card
	nextTexture = cardImages[nextCardPos].texture
	nextValue = values[nextCardPos]

	#where the next card in list is
	nextCardPos += 1

	#loops it back
	if nextCardPos == len(cardImages):
		nextCardPos = 0
	
	if not dealer:
		addCard(playerCards)
		return
	
	addCard(dealerCards)


#player hand display
@export var playerCards : Array[Sprite2D]

func resetCards() -> void:
	#sets all the textures of the player and dealer cards to null
	playerTotal = 0
	dealerTotal = 0
	for i in range(len(playerCards)):
		playerCards[i].texture = null
		dealerCards[i].texture = null

	


func addCard(toCheck : Array) -> void:
	var nextClearCard : Sprite2D

	#loops over array of textures to find one without a texture
	for i in range(len(toCheck)):
		if toCheck[i].texture == null:
			nextClearCard = toCheck[i]
			break
	
	#changes texture of the one without a texture
	nextClearCard.texture = nextTexture

	#if playercards is tocheck then the player has hit so playerTotal should be added to playerTotal
	if toCheck == playerCards:
		playerTotal += nextValue
	else:
		dealerTotal += nextValue
	
	if playerTotal > 21:
		print("bust")
		lose()
		return

	if dealerTotal > 21:
		print("dealer bust")
		win()
		return
	
	#if the dealer just hit and they can still hit they hit again
	if ((toCheck == dealerCards) and dealerHitCheck()) and hasStood:
		await wait(0.5)
		hit(true)

	
#dealer cards
@export var dealerCards : Array[Sprite2D]

func startGame() -> void:
	gameOver = false
	madeCards = false
	resetCards()

	winMessage = "You won!"

	await wait(0.5)
	
	#2 dealer hits and 2 player hits
	hit(true)
	await wait(0.2)
	hit(true)
	await wait(0.2)
	hit(false)
	await wait(0.2)
	hit(false)
	madeCards = true
	
	for i in range(len(dealerCards)):
		print(dealerCards[i].texture)
		print(playerCards[i].texture)

	#print(dealerTotal)
	#print(playerTotal)

	if playerTotal == 21:
		winMessage = "BLACKJACK!"
		win()
		return

func dealerHitCheck() -> bool:
	#dealer cannot hit if above 16
	if dealerTotal > 16:
		checkWinner()
		return false

	return true

func checkWinner() -> void:
	#without this the cards will be checked before they are made so you instantly loose and game breaks
	if not madeCards:
		return

	if dealerTotal > playerTotal:
		lose()
		return
	win()

func win() -> void:
	notif(winMessage + " Press new game", green, 1)
	gameOver = true

func lose() -> void:
	notif("You lost! Press new game", red, 1)
	gameOver = true


func _process(_delta):
	dealerLabel.text = "Dealer score: " + str(dealerTotal)
	playerLabel.text = "Your score: " + str(playerTotal)


func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


@export var notifLabel : PackedScene
@export var notifLocation : Node2D

func notif(message : String, colour : Color, fallSpeed : float) -> void:
	var notifInst = notifLabel.instantiate()
	notifInst.message = message
	notifInst.setColour(colour)
	notifInst.global_position = notifLocation.global_position
	notifInst.fallSpeed = fallSpeed
	get_tree().get_root().add_child(notifInst)


func newGame() -> void:
	if not gameOver:
		notif("You must finish this game!", red, 5)
		return
	
	gameOver = false
	notif("Game starting", green, 5)
	await wait(0.2)
	startGame()

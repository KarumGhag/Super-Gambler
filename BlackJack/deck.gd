extends Node2D

class_name Deck

@export var cards : Array[Sprite2D]

@export var ace : Array[Sprite2D]
@export var two : Array[Sprite2D]
@export var three : Array[Sprite2D]
@export var four : Array[Sprite2D]
@export var five : Array[Sprite2D]
@export var six : Array[Sprite2D]
@export var seven : Array[Sprite2D]
@export var eight : Array[Sprite2D]
@export var nine : Array[Sprite2D]
@export var ten : Array[Sprite2D]
@export var king : Array[Sprite2D]
@export var queen : Array[Sprite2D]

var cardArrayArray : Array[Array] = [ace, two, three, four, five, six, seven, eight, nine, ten, king, queen]

var values : Array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10]
var deck : Array = values
var cardsShuffled : Array

func _ready():
	#shuffler(values)

	pass
	#var x = 1
	#var y = 0
	#var values = []

	#for i in range(len(cards)):
	#    values.append(x)
	#    if x < 10:
	#        x += 1

	#    if x == 10:
	#        y += 1
		
	#    if x == 10 and y == 4:
	#        y = 0
	#        x = 1
	
	#print(values)

func shuffler(value):
	value.shuffle()
	
	ace.shuffle()
	two.shuffle()
	three.shuffle()
	four.shuffle()
	five.shuffle()
	six.shuffle()
	eight.shuffle()
	nine.shuffle()
	ten.shuffle()
	king.shuffle()
	queen.shuffle()

	var tens : int = 0
	var kings : int = 0
	var queens : int = 0

	for i in range(len(value)):
		if value[i] == 1:
			cardsShuffled.append(ace[0])
			ace[0] = ace[1]

		if value[i] == 2:
			cardsShuffled.append(two[0])
			two[0] = two[1]

		if value[i] == 3:
			cardsShuffled.append(three[0])
			three[0] = three[1]

		if value[i] == 4:
			cardsShuffled.append(four[0])
			four[0] = four[1]

		if value[i] == 5:
			cardsShuffled.append(five[0])
			five[0] = five[1]

		if value[i] == 6:
			cardsShuffled.append(six[0])
			six[0] = six[1]

		if value[i] == 7:
			cardsShuffled.append(seven[0])
			seven[0] = seven[1]

		if value[i] == 8:
			cardsShuffled.append(eight[0])
			eight[0] = eight[1]

		if value[i] == 9:
			cardsShuffled.append(nine[0])
			nine[0] = nine[1]

		if value[i] == 10 and tens < 3:
			cardsShuffled.append(ten[0])
			ten[0] = ten[1]
			tens += 1

		if value[i] == 10 and kings < 3:
			cardsShuffled.append(king[0])
			king[0] = king[1]
			kings += 1 

		if value[i] == 10 and queens < 3:
			cardsShuffled.append(queen[0])
			queen[0] = queen[1]
			queens += 1



	var returns = [cardsShuffled, values]
	return returns
		

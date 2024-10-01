extends Node2D

class_name SlotManager

@export var slots : Array[Slot]

var results : Array = [null, null, null]
var spinning : Array = [null, null, null]

var gotResults : bool = false

@export var spinButton : Button

func _ready() -> void:
	spinButton.connect("button_down", spin)

func _process(_delta) -> void:
	if not gotResults:
		if spinning[0] == false and spinning[1] == false and spinning[2] == false:
			#print(results)
			check()

@export var slotMachine : Game

func check() -> void:
	if results[0] == results[1] and results[1] == results[2]:
		slotMachine.win()
		gotResults = true
		spinning = [null, null, null]
	else:
		slotMachine.lose()
		gotResults = true
		spinning = [null, null, null]
	print(results)

func spin() -> void:
	
	if (spinning[0] == null and spinning[1] == null and spinning[2] == null) or (spinning[0] == false and spinning[1] == false and spinning[2] == false):
		
		for i in range(len(slots)):
			#print("spin")
			slots[i].genSpin()
		

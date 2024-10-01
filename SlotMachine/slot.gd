extends Sprite2D

class_name Slot

var timesToSpin : int
var colours : Array[Color] = [Color(255, 0, 0), Color(0, 255, 0), Color(0, 0, 255)]

var currentColour : Color = colours[0]
var currentColourNum : int = 0
var nextColour : int = currentColourNum + 1

var spinCoolDown : Timer = Timer.new()
var timePerSpin : float = 0.25
var timesSpun : int = 0

var result : int

@export var resultTxt : Label

@export var slotManager : SlotManager
@export var slotNum : int

var spinning : bool = false

func _ready() -> void:
	#genSpin()
	add_child(spinCoolDown)
	
	spinCoolDown.autostart = false
	spinCoolDown.one_shot = false
	spinCoolDown.connect("timeout", spin)
	

func genSpin() -> void:
	timesSpun = 0
	timesToSpin = randi_range(5, 20)
	timePerSpin = randf_range(0.15, 0.25)
	spinCoolDown.start(timePerSpin)
	slotManager.gotResults = false


func spin() -> void:
	
	spinning = true
	#resultTxt.text = str(currentColourNum)

	currentColourNum = nextColour
	currentColour = colours[nextColour]
	nextColour += 1
	timesSpun += 1
	
	if currentColourNum < 0:
		currentColourNum = len(colours)
	if currentColourNum >= len(colours):
		currentColourNum = 0
	
	if timesSpun >= timesToSpin:
		spinCoolDown.stop()

		result = currentColourNum
		slotManager.results[slotNum] = currentColourNum

		spinning = false
		slotManager.spinning[slotNum] = spinning

		print("not spinning ", slotManager.spinning)
		return
		
	timePerSpin *= 1.04

	spinCoolDown.start(timePerSpin)

func changeColour(newColour : Color):
	currentColour = newColour

func _process(_delta) -> void:
	
	modulate = currentColour
	if nextColour == len(colours):
		nextColour = 0

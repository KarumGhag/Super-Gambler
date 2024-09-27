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

func _ready() -> void:
	genSpin()
	add_child(spinCoolDown)
	
	spinCoolDown.autostart = false
	spinCoolDown.one_shot = false
	spinCoolDown.connect("timeout", spin)
	
	timePerSpin = randf_range(0.2, 0.35)
	spinCoolDown.start(timePerSpin)

	

func genSpin() -> void:
	timesToSpin = randi_range(5, 30)


func spin() -> void:
	currentColour = colours[nextColour]
	nextColour += 1
	timesSpun += 1
	if timesSpun >= timesToSpin:
		spinCoolDown.stop()
		return
	timePerSpin *= 1.05
	print(timePerSpin)
	spinCoolDown.start(timePerSpin)

func changeColour(newColour : Color):
	currentColour = newColour

func _process(_delta) -> void:
	modulate = currentColour
	if nextColour == len(colours):
		nextColour = 0
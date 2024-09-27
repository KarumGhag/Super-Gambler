extends Sprite2D

class_name Slot

var timesToSpin : int
var colours : Dictionary = {
	"Red" : Color(255, 0, 0),
	"Green" : Color(0, 255, 0),
	"Blue" : Color(0, 0, 255),
}

var currentColour : Color = colours["Red"]
var currentColourNum : int = 0
var nextColour : int = 1

func _ready() -> void:
	modulate = currentColour

func spin() -> void:
	timesToSpin = randi_range(0, len(colours) - 1)
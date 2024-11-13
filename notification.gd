extends Node2D

class_name notification

@export var label : Label
var message : String

var fallSpeed : float = 5

func _process(delta) -> void:
	label.text = message
	fallSpeed *= 1.025
	global_position.y += fallSpeed * delta
	if global_position.y > 1000:
		queue_free()
	
func setColour(colour : Color) -> void:
	label.add_theme_color_override("font_color", Color(colour))
	return

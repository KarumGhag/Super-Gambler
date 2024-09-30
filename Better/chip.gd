extends Sprite2D

class_name Chip

@export var value : int
@export var hitbox : Area2D

@export var mouseObj : Area2D

var canClick : bool = false

var betAmount : int
@export var betManager : BetManager

func _ready() -> void:
	hitbox.connect("area_entered", mouseTouching)
	hitbox.connect("area_exited", mouseLeaving)

func mouseTouching(area) -> void:
	if area == mouseObj:
		canClick = true

func mouseLeaving(area) -> void:
	if area == mouseObj:
		canClick = false

func _process(_delta) -> void:
	if canClick and Input.is_action_just_pressed("click"):
		addBet()
	if canClick and Input.is_action_just_pressed("removeBet"):
		takeBet()
	mouseObj.position = get_global_mouse_position()

func addBet() -> void:
	betManager.addBet(value)


func takeBet() -> void:
	betManager.takeBet(value)

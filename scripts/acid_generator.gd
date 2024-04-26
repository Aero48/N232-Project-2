extends Area2D

@export var timer: Timer
@export var velocity: Vector2
@export var delay: float

const ACID_BUBBLE = preload("res://game_objects/acid_bubble.tscn")

func createBubble():
	var acidBubbleInstance = ACID_BUBBLE.instantiate()
	acidBubbleInstance.velocity = velocity
	add_child(acidBubbleInstance)

func _ready():
	createBubble()
	timer.wait_time = delay
	timer.start()

func _on_timer_timeout():
	createBubble()

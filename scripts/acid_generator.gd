#Generates acid bubbles at a set interval. Bubble velocity and generation interval can be set per instance
extends Area2D

@export var timer: Timer
@export var velocity: Vector2
@export var delay: float

#Preload acid bubble scene
const ACID_BUBBLE = preload("res://game_objects/acid_bubble.tscn")

#Instantiates bubble instances
func createBubble():
	var acidBubbleInstance = ACID_BUBBLE.instantiate()
	acidBubbleInstance.velocity = velocity
	add_child(acidBubbleInstance)

#Creates a bubble on ready and starts timer
func _ready():
	createBubble()
	timer.wait_time = delay
	timer.start()

func _on_timer_timeout():
	createBubble()
	
func _process(delta):
	if get_node("/root/GameController").gamePaused:
		timer.paused = true
	else:
		timer.paused = false

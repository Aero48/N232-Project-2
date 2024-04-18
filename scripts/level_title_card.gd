extends Node2D

@export var timer: Timer
@export var levelLabel: Label

var nextLevel
var nextLevelStartPoint

# Called when the node enters the scene tree for the first time.
func _ready():
	nextLevel = get_node("/root/GameController").nextLevel
	levelLabel.text = nextLevel
	timer.start()
	await timer.timeout
	get_tree().change_scene_to_file("res://levels/"+nextLevel+".tscn")


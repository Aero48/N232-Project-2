extends Node2D

@export var timer: Timer
@export var levelLabel: Label

var nextLevel
var nextLevelStartPoint

#Displays the level queued, then sends the player there
func _ready():
	nextLevel = get_node("/root/GameController").nextLevel
	levelLabel.text = nextLevel
	timer.start()
	await timer.timeout
	get_tree().change_scene_to_file("res://levels/"+nextLevel+".tscn")


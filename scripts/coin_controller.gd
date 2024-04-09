extends CanvasLayer

#Exported variables so they can be set per level
@export var level: int
@export var coins: int

#Audio player exports
@export var coinSound: AudioStreamPlayer
@export var levelCompleteSound: AudioStreamPlayer

#Timer exports
@export var nextLevelTimer: Timer

#Score label export
@export var scoreLabel: Label

#Current player coins in level
var score = 0

#Makes sure next level exists before starting it
func change_level():
	if ResourceLoader.exists("res://levels/level_"+str(level+1)+".tscn"):
		get_tree().change_scene_to_file("res://levels/level_"+str(level+1)+".tscn")
	else:
		get_tree().change_scene_to_file("res://levels/title.tscn")
	
func coin_collected():
	score += 1
	scoreLabel.text = str(score)+"/" + str(coins)
	#when all coins collected, disable player movement, wait a few seconds then start the next level
	if score >= coins:
		get_node("/root/Platformer/Player").inputEnabled = false
		levelCompleteSound.play()
		get_node("/root/GameController").levelComplete = true
		nextLevelTimer.start()
		await nextLevelTimer.timeout
		change_level()
	else:
		coinSound.play()
		
#Sets up the coin label in the top left of the screen
func _ready():
	scoreLabel.text = str(score)+"/" + str(coins)
	

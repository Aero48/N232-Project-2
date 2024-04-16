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
		get_node("/root/GameController").change_scene("1-"+str(level+1), true)
	else:
		coinSound.play()
		
#Sets up the coin label in the top left of the screen
func _ready():
	scoreLabel.text = str(score)+"/" + str(coins)
	

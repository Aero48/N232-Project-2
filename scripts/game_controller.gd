extends CanvasLayer

#Exported variables so they can be set per level
@export var level: int
@export var coins: int

#Audio player exports
@export var coinSound: AudioStreamPlayer
@export var deathSound: AudioStreamPlayer
@export var levelCompleteSound: AudioStreamPlayer

#Timer exports
@export var deathTimer: Timer
@export var nextLevelTimer: Timer

#Score label export
@export var scoreLabel: Label

#Current player coins in level
var score = 0

#Certain things disable themselves when level is completed
var levelComplete = false

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
		levelComplete = true
		nextLevelTimer.start()
		await nextLevelTimer.timeout
		change_level()
	else:
		coinSound.play()

func player_death():
	#Players cannot die after collecting the last coin in a level
	if !levelComplete:
		#Disable player input, wait a couple seconds, then reload the scene
		get_node("/root/Platformer/Player").inputEnabled = false
		deathSound.play()
		deathTimer.start()
		await deathTimer.timeout
		get_tree().reload_current_scene()
		
#Sets up the coin label in the top left of the screen
func _ready():
	scoreLabel.text = str(score)+"/" + str(coins)
	

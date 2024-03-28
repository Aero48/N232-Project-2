extends CanvasLayer

@export var level: int
@export var coins: int
@export var coinSound: AudioStreamPlayer
@export var deathSound: AudioStreamPlayer
@export var levelCompleteSound: AudioStreamPlayer

@export var deathTimer: Timer
@export var nextLevelTimer: Timer

var score = 0

var scoreLabel 

var levelComplete = false

	
func change_level():
	if ResourceLoader.exists("res://levels/level_"+str(level+1)+".tscn"):
		get_tree().change_scene_to_file("res://levels/level_"+str(level+1)+".tscn")
	else:
		get_tree().change_scene_to_file("res://levels/title.tscn")
	
func coin_collected():
	score += 1
	get_node("/root/Platformer/GameController/Score").text = str(score)+"/" + str(coins)
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
	if !levelComplete:
		get_node("/root/Platformer/Player").inputEnabled = false
		deathSound.play()
		deathTimer.start()
		await deathTimer.timeout
		get_tree().reload_current_scene()
		
func _ready():
	get_node("/root/Platformer/GameController/Score").text = str(score)+"/" + str(coins)
	

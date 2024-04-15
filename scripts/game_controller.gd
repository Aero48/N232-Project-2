extends Node

var currentEffect = 0

var gamePaused = false

var playerEffects = [
	{
		"name": "Normal",
		"collected": true
	},
	{
		"name": "Double Jump",
		"collected": true
	},
	{
		"name": "Skates",
		"collected": true
	},
	{
		"name": "Iron",
		"collected": true
	}
]

#Certain things disable themselves when level is completed
var levelComplete = false

#Makes sure next level exists before starting it
func change_scene(level):
	if ResourceLoader.exists("res://levels/"+level+".tscn"):
		get_tree().change_scene_to_file("res://levels/"+level+".tscn")
	else:
		get_tree().change_scene_to_file("res://levels/title.tscn")

func player_death():
	#Players cannot die after collecting the last coin in a level
	if !levelComplete:
		#Disable player input, wait a couple seconds, then reload the scene
		get_node("/root/Platformer/Player").inputEnabled = false
		get_node("/root/Platformer/Player").deathSound.play()
		get_node("/root/Platformer/Player").isAlive = false
		await get_tree().create_timer(2).timeout
		get_tree().reload_current_scene()
		
func pause():
	gamePaused = true
	print("pause")
	get_node("/root/Platformer/PauseMenu").showMenu()
	
func unPause():
	gamePaused = false
	print("unpause")
	get_node("/root/Platformer/PauseMenu").hideMenu()
	
func _input(event):
	if event.is_action_pressed("pause") and get_node("/root/Platformer/PauseMenu") and !levelComplete and get_node("/root/Platformer/Player").isAlive:
		if gamePaused:
			unPause()
		else:
			pause()

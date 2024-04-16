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
		"collected": false
	},
	{
		"name": "Skates",
		"collected": false
	},
	{
		"name": "Iron",
		"collected": false
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
		
func saveMenu():
	gamePaused = true
	get_node("/root/Platformer/SaveMenu").showMenu()
func closeSaveMenu():
	gamePaused = false
	get_node("/root/Platformer/SaveMenu").hideMenu()
		
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
			
func saveData():
	var save_dict = {
		"effects": playerEffects
	}
	
	return JSON.stringify(save_dict)
	
func saveGame(saveNum):
	var file = FileAccess.open("user://save_game_"+str(saveNum)+".txt", FileAccess.WRITE)
	file.store_string(saveData())
	print("Game saved to file " + str(saveNum) + ". Data saved: " + saveData())
	
func loadGame(saveNum):
	var file = FileAccess.open("user://save_game_"+str(saveNum)+".txt", FileAccess.READ)
	var content = file.get_as_text()
	var load_dict = JSON.parse_string(content)
	print(load_dict)
	return load_dict
	
func loadData(saveData):
	playerEffects = saveData.effects


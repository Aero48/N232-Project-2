extends Node

var currentEffect = 0

var gamePaused = false

#variable for if the hub has been visited. makes the hub button in the pause menu work
var hubVisited = false

#If a level has a title card before it, this allows the level to be loaded after the card
var nextLevel

#refers to the startpoint the player originated from in the current scene
var levelStartPoint

#preload dead player node
const DEADPLAYER = preload("res://game_objects/deadPlayer.tscn")

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

func spawnPlayer(key, position):
	if key == levelStartPoint:
		get_node("/root/Platformer/Player").position = position
		

func createDeadPlayer():
	var deadPlayerInstance = DEADPLAYER.instantiate()
	deadPlayerInstance.position = get_node("/root/Platformer/Player").position
	deadPlayerInstance.sprite.flip_h = get_node("/root/Platformer/Player").sprite.flip_h
	if get_node("/root/Platformer/Player").velocity.x > 0:
		deadPlayerInstance.direction = -1
	elif get_node("/root/Platformer/Player").velocity.x < 0:
		deadPlayerInstance.direction = 1
	else:
		deadPlayerInstance.direction = 0
			
	match get_node("/root/Platformer/Player").currentEffect:
		0: 
			deadPlayerInstance.sprite.texture = load("res://assets/character_0001.png")
		1:
			deadPlayerInstance.sprite.texture = load("res://assets/player_doublejump_1.png")
		2:
			deadPlayerInstance.sprite.texture = load("res://assets/player_skates_1.png")
		3:
			deadPlayerInstance.sprite.texture = load("res://assets/player_iron_1.png")
				
	deadPlayerInstance.z_index = 1
	add_child(deadPlayerInstance)
	

#Makes sure next level exists before starting it
func change_scene(level, hasTitleCard, startKey = null):
	if ResourceLoader.exists("res://levels/"+level+".tscn"):
		levelStartPoint = startKey
		if hasTitleCard:
			nextLevel = level
			get_tree().change_scene_to_file("res://levels/level_title_card.tscn")
		else:
			get_tree().change_scene_to_file("res://levels/"+level+".tscn")
	else:
		get_tree().change_scene_to_file("res://levels/temp.tscn")

func player_death():
	#Players cannot die after collecting the last coin in a level
	if !levelComplete and get_node("/root/Platformer/Player").isAlive:
		#Disable player input, wait a couple seconds, then reload the scene
		get_node("/root/Platformer/Player").inputEnabled = false
		get_node("/root/Platformer/Player").deathSound.play()
		get_node("/root/Platformer/Player").isAlive = false
		createDeadPlayer()
		await get_tree().create_timer(2).timeout
		change_scene(nextLevel, true)
		
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
		if !gamePaused:
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
	
func collectEffect(effect):
	for playerEffect in playerEffects:
		if playerEffect.name == effect:
			playerEffect.collected = true
			
func checkEffect(effect):
	for playerEffect in playerEffects:
		if playerEffect.name == effect and playerEffect.collected:
			return true
			
	return false

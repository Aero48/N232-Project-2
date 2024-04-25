extends Node2D

@export var startTimer: Timer
@export var startSound: AudioStreamPlayer
@export var selectSound: AudioStreamPlayer
@export var backSound: AudioStreamPlayer

@export var startBtn: Button

@export var mainMenu: Control
@export var loadMenu: Control

#Load save buttons
@export var file1Btn: Button
@export var file2Btn: Button
@export var file3Btn: Button

#File progress labels
@export var file1Label: Label
@export var file2Label: Label
@export var file3Label: Label

#Delete file toggle button
@export var deleteFileToggle: CheckButton

var gameStarted = false

var deleteSaveMode = false

#Save data is temporarily stored here
var file1
var file2
var file3

func _ready():
	startBtn.grab_focus()
	
func startGame():
	gameStarted = true
	startSound.play()
	startTimer.start()
	await startTimer.timeout
	get_node("/root/GameController").change_scene("1-1", true)
	
func startGameHub():
	gameStarted = true
	startSound.play()
	startTimer.start()
	await startTimer.timeout
	get_node("/root/GameController").hubVisited = true
	get_node("/root/GameController").change_scene("tunnel", true, "save_point")

func _on_start_btn_pressed():
	if !gameStarted:
		startGame()


func _on_quit_btn_pressed():
	if !gameStarted:
		backSound.play()
		get_tree().quit()
		

func get_effects_progress(saveFile):
	var fileEffects = saveFile.effects
	var count = 0
	for effect in fileEffects:
		if effect.collected:
			count+=1
	return str(count) + "/" + str(fileEffects.size())
			

func initLoadMenu():
	mainMenu.hide()
	deleteSaveMode = false
	deleteFileToggle.button_pressed = false
	loadMenu.show()
	
	file1Btn.grab_focus()
	
	if FileAccess.file_exists("user://save_game_1.txt"):
		file1 = get_node("/root/GameController").loadGame(1)
		file1Label.text = get_effects_progress(file1)
	else:
		file1Btn.disabled = true
		file1Label.text = ""
		
	if FileAccess.file_exists("user://save_game_2.txt"):
		file2 = get_node("/root/GameController").loadGame(2)
		file2Label.text = get_effects_progress(file2)
	else:
		file2Btn.disabled = true
		file2Label.text = ""
		
	if FileAccess.file_exists("user://save_game_3.txt"):
		file3 = get_node("/root/GameController").loadGame(3)
		file3Label.text = get_effects_progress(file3)
	else:
		file3Btn.disabled = true
		file3Label.text = ""

func _on_load_btn_pressed():
	if !gameStarted:
		selectSound.play()
		initLoadMenu()


func _on_back_btn_pressed():
	if !gameStarted:
		backSound.play()
		mainMenu.show()
		loadMenu.hide()
		startBtn.grab_focus()
		
func startFromLoadedFile(fileNum):
	if deleteSaveMode:
		backSound.play()
		var dir = DirAccess.open("user://")
		dir.remove("save_game_"+str(fileNum)+".txt")
		initLoadMenu()
	else:
		if !gameStarted:
			match fileNum:
				1:
					get_node("/root/GameController").loadData(file1)
				2:
					get_node("/root/GameController").loadData(file2)
				3:
					get_node("/root/GameController").loadData(file3)
			startGameHub()


func _on_file_1_btn_pressed():
	startFromLoadedFile(1)

func _on_file_2_btn_pressed():
	startFromLoadedFile(2)
	
func _on_file_3_btn_pressed():
	startFromLoadedFile(3)


func _on_delete_mode_toggle_pressed():
	if !gameStarted:
		deleteSaveMode = !deleteSaveMode

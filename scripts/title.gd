extends Node2D

@export var startTimer: Timer
@export var startSound: AudioStreamPlayer

var gameStarted = false

func _on_start_btn_pressed():
	if !gameStarted:
		gameStarted = true
		startSound.play()
		startTimer.start()
		await startTimer.timeout
		get_node("/root/GameController").change_scene("1-1")


func _on_quit_btn_pressed():
	if !gameStarted:
		get_tree().quit()

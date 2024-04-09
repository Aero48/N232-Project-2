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
		get_tree().change_scene_to_file("res://levels/level_1.tscn")


func _on_quit_btn_pressed():
	if !gameStarted:
		get_tree().quit()

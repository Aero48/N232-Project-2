extends Node2D

@export var startTimer: Timer
@export var startSound: AudioStreamPlayer



func _on_start_pressed():
	startSound.play()
	startTimer.start()
	await startTimer.timeout
	get_tree().change_scene_to_file("res://levels/level_1.tscn")
	pass

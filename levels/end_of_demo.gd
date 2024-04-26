extends Node2D

@export var backBtn: Button

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	backBtn.grab_focus()

func _on_quit_btn_pressed():
	get_tree().change_scene_to_file("res://levels/title.tscn")

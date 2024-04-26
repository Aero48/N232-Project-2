extends Node2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_quit_btn_pressed():
	get_tree().change_scene_to_file("res://levels/title.tscn")

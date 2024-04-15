extends CanvasLayer

@export var main: NinePatchRect
@export var effects: NinePatchRect

func showMenu():
	print("showmenu")
	show()
	main.show()
	effects.hide()
	
func hideMenu():
	hide()

func _on_effects_btn_pressed():
	main.hide()
	effects.show()


func _on_quit_btn_pressed():
	get_tree().change_scene_to_file("res://levels/title.tscn")


func _on_effects_back_btn_pressed():
	effects.hide()
	main.show()


func _on_main_back_btn_pressed():
	get_node("/root/GameController").unPause()

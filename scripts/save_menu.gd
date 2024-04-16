extends CanvasLayer

@export var file1Btn: Button

func showMenu():
	show()
	file1Btn.grab_focus()
	
func hideMenu():
	hide()
	file1Btn.grab_focus()


func _on_file_1_btn_pressed():
	get_node("/root/GameController").saveGame(1)


func _on_file_2_btn_pressed():
	get_node("/root/GameController").saveGame(2)


func _on_file_3_btn_pressed():
	get_node("/root/GameController").saveGame(3)


func _on_back_btn_pressed():
	get_node("/root/GameController").closeSaveMenu()

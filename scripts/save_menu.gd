extends CanvasLayer

@export var file1Btn: Button
@export var yesSound: AudioStreamPlayer 

#Shows save menu
func showMenu():
	show()
	file1Btn.grab_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
#Hides save menu
func hideMenu():
	hide()
	file1Btn.grab_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

#Saves data to file depending on file selected
func _on_file_1_btn_pressed():
	get_node("/root/GameController").saveGame(1)
	yesSound.play()
	get_node("/root/GameController").closeSaveMenu()

func _on_file_2_btn_pressed():
	get_node("/root/GameController").saveGame(2)
	yesSound.play()
	get_node("/root/GameController").closeSaveMenu()

func _on_file_3_btn_pressed():
	get_node("/root/GameController").saveGame(3)
	yesSound.play()
	get_node("/root/GameController").closeSaveMenu()

#Closes save menu
func _on_back_btn_pressed():
	get_node("/root/GameController").closeSaveMenu()

extends CanvasLayer

@export var backBtn: Button

func messageOpen():
	show()
	backBtn.grab_focus()


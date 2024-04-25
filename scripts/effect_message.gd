extends CanvasLayer

@export var backBtn: Button
@export var effectBase: Area2D

func messageOpen():
	get_node("/root/GameController").gamePaused = true
	show()
	backBtn.grab_focus()
	
func messageClose():
	hide()
	get_node("/root/GameController").gamePaused = false
	get_node("/root/GameController").collectEffect(effectBase.effectName)
	effectBase.queue_free()



func _on_back_btn_pressed():
	messageClose()

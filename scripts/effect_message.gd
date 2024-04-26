extends CanvasLayer

@export var backBtn: Button
@export var effectBase: Area2D
@export var messageLabel: Label

#Displays the message box with the correct message depending on the effect collected
func messageOpen():
	get_node("/root/GameController").gamePaused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	match effectBase.effectName:
		"Iron":
			messageLabel.text = "Iron effect collected! Grants immunity to most hazards with the cost of slow speed and low jumps."
		"Double Jump":
			messageLabel.text = "Double jump effect collected! Grants the ability to double jump with the cost of not being able to crush enemies."
		"Skates":
			messageLabel.text = "Skates effect collected! Grants the ability to move super fast with the cost of slippery controls."
	
	show()
	backBtn.grab_focus()

#Effect is officially collected when the message box is closed.
func messageClose():
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_node("/root/GameController").gamePaused = false
	get_node("/root/GameController").collectEffect(effectBase.effectName)
	effectBase.queue_free()


func _on_back_btn_pressed():
	messageClose()

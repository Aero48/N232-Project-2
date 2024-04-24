extends Node2D

var playerWithinRange = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		playerWithinRange = true
		body.eLabel.show()

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		playerWithinRange = false
		body.eLabel.hide()
		
func _input(event):
	if event.is_action_pressed("interact") and playerWithinRange and !get_node("/root/GameController").gamePaused:
		get_node("/root/GameController").saveMenu()

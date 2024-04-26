extends Node2D

#Determines whether player is close enough to the pillar to open the save menu
var playerWithinRange = false

#Player enters range -> playerWithinRange = true
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		playerWithinRange = true
		body.eLabel.show()

#Player exits range -> playerWithinRange = false
func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		playerWithinRange = false
		body.eLabel.hide()

#Only opens menu if player is in range and game isn't already paused
func _input(event):
	if event.is_action_pressed("interact") and playerWithinRange and !get_node("/root/GameController").gamePaused:
		get_node("/root/GameController").saveMenu()

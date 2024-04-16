extends Node2D

var playerWithinRange = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		playerWithinRange = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		playerWithinRange = false
		
func _input(event):
	if event.is_action_pressed("interact") and playerWithinRange:
		get_node("/root/GameController").saveMenu()

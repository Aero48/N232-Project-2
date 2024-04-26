extends StaticBody2D

#Kills player unless using the iron effect
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		if body.currentEffect != 3:
			body.hide()
			get_node("/root/GameController").player_death()

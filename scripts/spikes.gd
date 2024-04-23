extends StaticBody2D

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		if body.currentEffect != 3:
			get_node("/root/GameController").player_death()

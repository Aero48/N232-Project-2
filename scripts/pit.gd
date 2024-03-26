extends Area2D



func _on_body_entered(body):
	if body.is_in_group("player"):
		
		get_node("/root/Platformer/GameController").player_death()
	else:
		body.queue_free()

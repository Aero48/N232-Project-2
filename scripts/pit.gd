extends Area2D

#If player collides, kill player. If enemy collides, delete the instance
func _on_body_entered(body):
	if body.is_in_group("player"):
		get_node("/root/GameController").player_death()
	elif body.is_in_group("enemies"):
		body.queue_free()

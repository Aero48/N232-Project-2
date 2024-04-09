extends Area2D

var gameController 

#When a coin is collided with, run the coin_collected function in game controller and delete the instance
func _on_body_entered(body):
	if body.is_in_group("player"):
		get_node("/root/Platformer/CoinController").coin_collected()
		queue_free()

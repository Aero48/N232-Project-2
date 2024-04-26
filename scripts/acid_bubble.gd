extends Area2D

@export var velocity: Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity*delta
	

func _on_body_entered(body):
	if body.is_in_group("player") and body.is_visible():
		body.hide()
		get_node("/root/GameController").player_death()

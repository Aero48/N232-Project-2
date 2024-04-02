extends Area2D

@export var sprite: AnimatedSprite2D

#Makes players and enemies bounce on springs when touched
func _on_body_entered(body):
	if body.is_in_group("player"):
		body.springJump()
		sprite.play("boing")
	elif body.is_in_group("enemies"):
		body.springJump()
		sprite.play("boing")

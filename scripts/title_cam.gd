extends Camera2D

#Moves to the right to make background scroll
func _process(delta):
	position.x += 200 * delta

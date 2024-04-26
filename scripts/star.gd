extends Sprite2D

@export var animation: AnimationPlayer

#Plays animation then destroys self
func _ready():
	await animation.animation_finished
	queue_free()


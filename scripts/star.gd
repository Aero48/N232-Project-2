extends Sprite2D

@export var animation: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	await animation.animation_finished
	queue_free()


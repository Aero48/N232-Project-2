#This is the arrow that shows up on 1-3 to let you know to jump in the pit
extends Sprite2D

@onready var animation = $AnimationPlayer

func _on_arrow_trigger_body_entered(body):
	if body.is_in_group("player"):	
		show()

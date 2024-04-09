extends Sprite2D

@onready var animation = $AnimationPlayer




func _on_arrow_trigger_body_entered(body):
	if body.is_in_group("player"):	
		show()

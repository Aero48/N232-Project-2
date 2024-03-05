extends Area2D

var gameController 


# Called when the node enters the scene tree for the first time.
func _ready():
	#gameController = 
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	get_node("/root/Platformer/GameController").coin_collected()
	queue_free()

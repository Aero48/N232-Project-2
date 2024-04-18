extends Area2D

@export var targetLevel: String
@export var targetStartPoint: String
@export var targetHasTitleCard: bool

#whether or not a player is close enough to use the warp
var playerInRange = false

func _input(event):
	if event.is_action_pressed("up") and playerInRange:
		get_node("/root/GameController").change_scene(targetLevel, targetHasTitleCard, targetStartPoint)

func _on_body_entered(body):
	playerInRange = true

func _on_body_exited(body):
	playerInRange = false

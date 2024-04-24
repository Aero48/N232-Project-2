extends Area2D

@export var targetLevel: String
@export var targetStartPoint: String
@export var targetHasTitleCard: bool

#whether or not a player is close enough to use the warp
var playerInRange = false

func _input(event):
	if event.is_action_pressed("up") and playerInRange and !get_node("/root/GameController").gamePaused:
		get_node("/root/GameController").change_scene(targetLevel, targetHasTitleCard, targetStartPoint)

func _on_body_entered(body):
	if body.is_in_group("player"):
		playerInRange = true
		body.isInDoorway = true
		body.upIndicator.show()

func _on_body_exited(body):
	if body.is_in_group("player"):
		playerInRange = false
		body.isInDoorway = false
		body.upIndicator.hide()

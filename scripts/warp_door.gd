extends Area2D

#Exported variables

#Target level to send player to
@export var targetLevel: String

#Key for the start point in next level
@export var targetStartPoint: String

#Display title card?
@export var targetHasTitleCard: bool

#whether or not a player is close enough to use the warp
var playerInRange = false

#Only warps player if they are in range and the game isn't paused
func _input(event):
	if event.is_action_pressed("up") and playerInRange and !get_node("/root/GameController").gamePaused:
		get_node("/root/GameController").change_scene(targetLevel, targetHasTitleCard, targetStartPoint)

#Sets variable when area is entered and exited
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

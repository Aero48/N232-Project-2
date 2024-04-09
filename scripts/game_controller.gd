extends Node

#Certain things disable themselves when level is completed
var levelComplete = false

func player_death():
	#Players cannot die after collecting the last coin in a level
	if !levelComplete:
		#Disable player input, wait a couple seconds, then reload the scene
		get_node("/root/Platformer/Player").inputEnabled = false
		get_node("/root/Platformer/Player").deathSound.play()
		await get_tree().create_timer(2).timeout
		get_tree().reload_current_scene()

extends CanvasLayer

#Exported menus
@export var main: NinePatchRect
@export var effects: NinePatchRect

#Exported menu buttons
@export var effectsBtn: Button
@export var hubBtn: Button
@export var normalBtn: Button
@export var jumpBtn: Button
@export var skatesBtn: Button
@export var ironBtn: Button

#Sounds
@export var pauseSound: AudioStreamPlayer
@export var selectSound: AudioStreamPlayer
@export var backSound: AudioStreamPlayer
@export var powerupSound: AudioStreamPlayer

#Shows the main pause menu
func showMenu():
	pauseSound.play()
	show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	main.show()
	effects.hide()
	effectsBtn.grab_focus()
	
	#Only shows hub button if you've been there already
	if get_node("/root/GameController").hubVisited:	
		hubBtn.disabled = false
	
#Hides menu
func hideMenu():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	hide()

#Hide main menu and open effects menu.
func _on_effects_btn_pressed():
	selectSound.play()
	main.hide()
	effects.show()
	
	#Display collected effects and disable ones not collected
	if get_node("/root/GameController").playerEffects[1].collected:
		jumpBtn.disabled = false
	else:
		jumpBtn.disabled = true
		
	if get_node("/root/GameController").playerEffects[2].collected:
		skatesBtn.disabled = false
	else:
		skatesBtn.disabled = true
		
	if get_node("/root/GameController").playerEffects[3].collected:
		ironBtn.disabled = false
	else:
		ironBtn.disabled = true
		
	normalBtn.grab_focus()

#Send player back to title screen
func _on_quit_btn_pressed():
	get_node("/root/GameController").unPause()
	get_tree().change_scene_to_file("res://levels/title.tscn")

#Sends player back to main pause menu
func _on_effects_back_btn_pressed():
	backSound.play()
	effects.hide()
	main.show()
	effectsBtn.grab_focus()

#Unpauses game when back button pressed
func _on_main_back_btn_pressed():
	backSound.play()
	get_node("/root/GameController").unPause()

#Sets player's current effect based on button selected
func _on_normal_btn_pressed():
	powerupSound.play()
	get_node("/root/Platformer/Player").changeEffect(0, true)
	get_node("/root/GameController").unPause()
func _on_jump_btn_pressed():
	powerupSound.play()
	get_node("/root/Platformer/Player").changeEffect(1, true)
	get_node("/root/GameController").unPause()
func _on_skates_btn_pressed():
	powerupSound.play()
	get_node("/root/Platformer/Player").changeEffect(2, true)
	get_node("/root/GameController").unPause()
func _on_iron_btn_pressed():
	powerupSound.play()
	get_node("/root/Platformer/Player").changeEffect(3, true)
	get_node("/root/GameController").unPause()

#Sends player to hub when pressed
func _on_hub_btn_pressed():
	get_node("/root/GameController").unPause()
	get_node("/root/GameController").change_scene("hub", true)

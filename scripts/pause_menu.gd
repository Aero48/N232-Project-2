extends CanvasLayer

@export var main: NinePatchRect
@export var effects: NinePatchRect

@export var effectsBtn: Button

@export var normalBtn: Button
@export var jumpBtn: Button
@export var skatesBtn: Button
@export var ironBtn: Button

func showMenu():
	print("showmenu")
	show()
	main.show()
	effects.hide()
	effectsBtn.grab_focus()
	
func hideMenu():
	hide()

func _on_effects_btn_pressed():
	main.hide()
	effects.show()
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


func _on_quit_btn_pressed():
	get_tree().change_scene_to_file("res://levels/title.tscn")


func _on_effects_back_btn_pressed():
	effects.hide()
	main.show()
	effectsBtn.grab_focus()


func _on_main_back_btn_pressed():
	get_node("/root/GameController").unPause()


func _on_normal_btn_pressed():
	get_node("/root/Platformer/Player").changeEffect(0)
	get_node("/root/GameController").unPause()


func _on_jump_btn_pressed():
	get_node("/root/Platformer/Player").changeEffect(1)
	get_node("/root/GameController").unPause()


func _on_skates_btn_pressed():
	get_node("/root/Platformer/Player").changeEffect(2)
	get_node("/root/GameController").unPause()


func _on_iron_btn_pressed():
	get_node("/root/Platformer/Player").changeEffect(3)
	get_node("/root/GameController").unPause()

extends CanvasLayer


func _on_file_1_btn_pressed():
	get_node("/root/GameController").saveGame(1)


func _on_file_2_btn_pressed():
	get_node("/root/GameController").saveGame(2)


func _on_file_3_btn_pressed():
	get_node("/root/GameController").saveGame(3)


func _on_back_btn_pressed():
	get_tree().change_scene_to_file("res://levels/title.tscn")

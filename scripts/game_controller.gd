extends CanvasLayer

@export var level: int

var score = 0

var scoreLabel 

# Called when the node enters the scene tree for the first time.
func _ready():
	#scoreLabel = get_tree().get_root().find_node("Score")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func change_level():
	if ResourceLoader.exists("res://levels/level_"+str(level+1)+".tscn"):
		get_tree().change_scene_to_file("res://levels/level_"+str(level+1)+".tscn")
	
	
func coin_collected():
	score += 1
	get_node("/root/Platformer/GameController/Score").text = str(score)+"/5"
	if score >= 5:
		change_level()
	

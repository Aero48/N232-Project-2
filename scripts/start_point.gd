extends Area2D

#Used by game controller to determine which start point the player starts at
@export var key: String

func _ready():
	get_node("/root/GameController").spawnPlayer(key, position)

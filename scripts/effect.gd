extends Area2D

@export var effectName: String
@export var effectSprite: Resource

@export var spriteNode: Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if get_node("/root/GameController").checkEffect(effectName):
		queue_free()
	spriteNode.texture = effectSprite


func _on_body_entered(body):
	if body.is_in_group("player"):
		get_node("/root/GameController").collectEffect(effectName)
		queue_free()

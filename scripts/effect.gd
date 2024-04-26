extends Area2D

#Exported properties for the effect object
@export var effectName: String
@export var effectSprite: Resource

#Exported nodes for easy access
@export var spriteNode: Sprite2D
@export var effectMessage: CanvasLayer
@export var collectSound: AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	#If the player already has this effect, make it disappear from the scene
	if get_node("/root/GameController").checkEffect(effectName):
		queue_free()
	
	#Sets the sprite based on specified effect
	spriteNode.texture = effectSprite

#Opens collect message and destroys instance when collided with
func _on_body_entered(body):
	if body.is_in_group("player"):
		collectSound.play()
		spriteNode.hide()
		effectMessage.messageOpen()

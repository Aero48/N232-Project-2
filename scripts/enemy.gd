extends CharacterBody2D

#Exported nodes for access in code
@export var sprite: AnimatedSprite2D
@export var boingSound: AudioStreamPlayer

#Starting speed of enemies
var speed = -2000

#Maximum fall velocity
const MAX_FALL_SPEED = 500

#Initial vertical velocity when enemy bounces on spring
const SPRING_VELOCITY = -600.0

#Determines if enemy should be moving or not. Only turns true when enemy appears on screen.
var active = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#Plays spring sound and launches enemy
func springJump():
	boingSound.play()
	velocity.y = SPRING_VELOCITY

func _physics_process(delta):
	if active:
		#Makes enemy turn around when it collides with wall
		if is_on_wall():
			speed *= -1
			sprite.flip_h = !sprite.flip_h
		velocity.x = speed * delta
	
		# Add the gravity.
		if not is_on_floor():
			if velocity.y <= MAX_FALL_SPEED:
				velocity.y += gravity * delta
				
		#Movement does not work without this function
		move_and_slide()

#When player gets close enough, activate enemy behavior
func _on_visible_on_screen_notifier_2d_screen_entered():
	active = true;

#Controllers player/enemy collision
func _on_area_2d_body_entered(body):
	#Ensures body colliding with is a player and visible (checking visibility is a hacky way of determining if the player is dead or not)
	if body.is_in_group("player") and body.is_visible():
		#Only squash enemies if moving down
		if body.velocity.y>0:
			queue_free()
			body.enemySquash() 
		else:
			body.hide()
			get_node("/root/Platformer/GameController").player_death()

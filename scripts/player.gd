extends CharacterBody2D

#Timer that determines how long to give player decreased gravity during jump
@export var jumpTimer: Timer

#Connects to tilemap for camera boundaries
@export var tilemap: TileMap

#For controlling player animations
@export var sprite: AnimatedSprite2D

#Sound players
@export var jumpSound: AudioStreamPlayer
@export var slideSound: AudioStreamPlayer
@export var squashSound: AudioStreamPlayer
@export var hitSound: AudioStreamPlayer
@export var boingSound: AudioStreamPlayer
@export var deathSound: AudioStreamPlayer

#Player horizontal acceleration while in air
const AIR_ACCEL = 20.0
#Player horizontal acceleration while on the ground
const GROUND_ACCEL = 20.0
const GROUND_DECEL = 30.0
#Player max horizontal speed
const SPEED = 150.0
#Initial vertical velocity when player jumps
const JUMP_VELOCITY = -300.0
#Initial vertical velocity when player bounces on spring
const SPRING_VELOCITY = -600.0
#Maximum vertical speed when falling
const MAX_FALL_SPEED = 400

#Variable used to determine whether or not to play sliding sound
var isSliding = false

#Variable for whether the jump timer has finished or not
var jumpTimeout = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#Determines whether or not a player inputs are enabled
var inputEnabled = true

#Determines whether a player is alive or not. Used for disabling physics
var isAlive = true

#Player effect
var currentEffect = 1

#Determines whether a player has already used their double jump (applies only to the double jump effect)
var doubleJumped = false

# Runs when player stops holding the jump button, or starts moving down
func early_jump_timeout():
	jumpTimeout = true
	jumpTimer.stop()

#Collection of jump functions for different conditions. Play different sounds and have different jump velocities
func enemySquash():
	squashSound.play()
	velocity.y = JUMP_VELOCITY
	jumpTimeout = false
	#when player jumps, starts a timer that determines the maximum amount of time the player can hold jump for before gravity returns to normal
	jumpTimer.start()
	
func jump():
	jumpSound.play()
	velocity.y = JUMP_VELOCITY
	jumpTimeout = false
	#when player jumps, starts a timer that determines the maximum amount of time the player can hold jump for before gravity returns to normal
	jumpTimer.start()
	
func springJump():
	boingSound.play()
	velocity.y = SPRING_VELOCITY
	jumpTimeout = false
	#when player jumps, starts a timer that determines the maximum amount of time the player can hold jump for before gravity returns to normal
	jumpTimer.start()

func _physics_process(delta):
	if isAlive:
		# Add the gravity.
		if not is_on_floor():
			if velocity.y <= MAX_FALL_SPEED:
				velocity.y += gravity * delta
	
		#Stops the jump timer if player starts moving down (hits head on blocks above for example)
		if velocity.y > 0:
			early_jump_timeout()

		# Handle jump.
		if currentEffect != 1:
			if Input.is_action_just_pressed("jump") and is_on_floor() and inputEnabled:
				jump()
		else:
			if Input.is_action_just_pressed("jump") and !doubleJumped and inputEnabled:
				jump()
				doubleJumped = true
				
		if is_on_floor() and doubleJumped:
			doubleJumped = false
		
		#This sets the gravity to a lower value when player is holding the jump button (only applies if player has actually jumped, and the maximum time hasn't been reached)
		if Input.is_action_pressed("jump") and !jumpTimeout:
			gravity = ProjectSettings.get_setting("physics/2d/default_gravity")/4
		else:
			gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
			early_jump_timeout()
			
		

		# Get the input direction and handle the movement/deceleration.
		var direction = Input.get_axis("left", "right")
		if direction>0 and inputEnabled:
			sprite.flip_h = 1
			if velocity.x <= SPEED:
				if is_on_floor():
					velocity.x += direction * GROUND_ACCEL * delta * 60
				else:
					velocity.x += direction * AIR_ACCEL * delta * 60
		elif direction<0 and inputEnabled:
			sprite.flip_h = 0
			if velocity.x >= -SPEED:
				if is_on_floor():
					velocity.x += direction * GROUND_ACCEL * delta * 60
				else:
					velocity.x += direction * AIR_ACCEL * delta * 60
		else:
			#Makes player slow to a stop when not pressing left or right
			if is_on_floor():
				velocity.x = move_toward(velocity.x, 0, GROUND_DECEL*delta*60)
			else:
				velocity.x = move_toward(velocity.x, 0, AIR_ACCEL*delta*60)
		move_and_slide()

		# Play certain animations depending on the scenario
		if is_on_floor() and velocity.x != 0:
			#Animation plays at different speed depending on velocity
			sprite.speed_scale = abs(velocity.x) / SPEED
			sprite.animation = "walk"
		elif is_on_floor() and velocity.x == 0:
			sprite.animation = "idle"
		elif !is_on_floor() and velocity.y < 0:
			sprite.animation = "jump"
		else:
			sprite.animation = "fall"
	
		#Really zany code just to play a slide sound when player is sliding.
		if ((Input.is_action_pressed("left") && velocity.x > 60) or (Input.is_action_pressed("right") && velocity.x < -60)) && is_on_floor() && !isSliding:
			slideSound.play()
			isSliding = true
		else:
			slideSound.stop()
			isSliding = false
	
		#Bonk!
		if is_on_ceiling():
			hitSound.play()

#Disables the lower gravity when holding jump button
func _on_jump_timer_timeout():
	jumpTimeout = true
	
#When the player changes effect
func changeEffect(effect):
	currentEffect = effect
	
func _ready():
	sprite.play()
	sprite.flip_h = 1
	#When player is spawned in, sets the level complete variable in game controller to false
	get_node("/root/GameController").levelComplete = false

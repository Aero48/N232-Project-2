extends CharacterBody2D

#Timer that determines how long to give player decreased gravity during jump
@export var jumpTimer: Timer

#Connects to tilemap for camera boundaries
@export var tilemap: TileMap

@export var sprite: AnimatedSprite2D

#Player horizontal acceleration while in air
const AIR_ACCEL = 20.0
#Player horizontal acceleration while on the ground
const GROUND_ACCEL = 30.0
const GROUND_DECEL = 40.0
#Player max horizontal speed
const SPEED = 150.0
#Initial vertical velocity when player jumps
const JUMP_VELOCITY = -300.0
#Maximum vertical speed when falling
const MAX_FALL_SPEED = 500

#Variable for whether the jump timer has finished or not
var jumpTimeout = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Runs when player stops holding the jump button, or starts moving down
func early_jump_timeout():
	jumpTimeout = true
	jumpTimer.stop()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if velocity.y <= MAX_FALL_SPEED:
			velocity.y += gravity * delta
	
	#Stops the jump timer if player starts moving down (hits head on blocks above for example)
	if velocity.y > 0:
		early_jump_timeout()

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jumpTimeout = false
		#when player jumps, starts a timer that determines the maximum amount of time the player can hold jump for before gravity returns to normal
		jumpTimer.start()
		
	#This sets the gravity to a lower value when player is holding the jump button (only applies if player has actually jumped, and the maximum time hasn't been reached)
	if Input.is_action_pressed("ui_accept") and !jumpTimeout:
		gravity = ProjectSettings.get_setting("physics/2d/default_gravity")/4
	else:
		gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
		early_jump_timeout()
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction>0:
		sprite.flip_h = 1
		if velocity.x <= SPEED:
			if is_on_floor():
				velocity.x += direction * GROUND_ACCEL
			else:
				velocity.x += direction * AIR_ACCEL
	elif direction<0:
		sprite.flip_h = 0
		if velocity.x >= -SPEED:
			if is_on_floor():
				velocity.x += direction * GROUND_ACCEL
			else:
				velocity.x += direction * AIR_ACCEL
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, GROUND_DECEL)
		else:
			velocity.x = move_toward(velocity.x, 0, AIR_ACCEL)
	move_and_slide()

	if is_on_floor() and velocity.x != 0:
		sprite.animation = "walk"
	elif is_on_floor() and velocity.x == 0:
		sprite.animation = "idle"
	elif !is_on_floor() and velocity.y < 0:
		sprite.animation = "jump"
	else:
		sprite.animation = "fall"

func _on_jump_timer_timeout():
	jumpTimeout = true
	pass
	
func _ready():
	sprite.play()
	sprite.speed_scale = 2

extends CharacterBody2D

var speed = -100

const MAX_FALL_SPEED = 500

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity.x = speed
	if is_on_wall():
		speed *= -1
	
	# Add the gravity.
	if not is_on_floor():
		if velocity.y <= MAX_FALL_SPEED:
			velocity.y += gravity * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

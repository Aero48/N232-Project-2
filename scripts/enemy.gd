extends CharacterBody2D

@export var sprite: AnimatedSprite2D

var speed = -2000

const MAX_FALL_SPEED = 500

var active = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if active:
		
		if is_on_wall():
			speed *= -1
			sprite.flip_h = !sprite.flip_h
		velocity.x = speed * delta
	
	
		# Add the gravity.
		if not is_on_floor():
			if velocity.y <= MAX_FALL_SPEED:
				velocity.y += gravity * delta

		move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_entered():
	active = true;
	pass # Replace with function body.

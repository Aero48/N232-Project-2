extends RigidBody2D

@export var sprite: Sprite2D

var rng = RandomNumberGenerator.new()

var direction = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	apply_impulse(Vector2(rng.randf_range(0,200)*direction,-400))
	apply_torque_impulse(rng.randf_range(-8,8))


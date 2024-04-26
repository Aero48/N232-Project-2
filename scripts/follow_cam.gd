extends Camera2D
var maxOffset = 60

func _ready():
	#Automatically sets the camera boundaries based on tilemap size.
	var tilemap = get_parent().tilemap
	var mapRect = tilemap.get_used_rect()
	var tileSize = 18
	var worldSizeInPixels = mapRect.size * tileSize
	limit_right = worldSizeInPixels.x
	limit_bottom = worldSizeInPixels.y
	
#Camera control disabled due to lots of bugs
#func _process(delta):
	#if Input.is_action_pressed("up") and !player.isInDoorway:
		#offset.y = move_toward(offset.y, -maxOffset, 100 * delta)
	#elif Input.is_action_pressed("down"):
		#offset.y = move_toward(offset.y, maxOffset, 100 * delta)
	#else:
		#offset.y = move_toward(offset.y, 0, 100*delta)
	

extends Camera2D



# Called when the node enters the scene tree for the first time.
func _ready():
	var tilemap = get_parent().tilemap
	var mapRect = tilemap.get_used_rect()
	var tileSize = 18
	var worldSizeInPixels = mapRect.size * tileSize
	limit_right = worldSizeInPixels.x
	limit_bottom = worldSizeInPixels.y
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

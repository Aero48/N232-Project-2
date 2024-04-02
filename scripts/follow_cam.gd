extends Camera2D

func _ready():
	#Automatically sets the camera boundaries based on tilemap size. Doesn't work super well honestly
	var tilemap = get_parent().tilemap
	var mapRect = tilemap.get_used_rect()
	var tileSize = 18
	var worldSizeInPixels = mapRect.size * tileSize
	limit_right = worldSizeInPixels.x
	limit_bottom = worldSizeInPixels.y
	

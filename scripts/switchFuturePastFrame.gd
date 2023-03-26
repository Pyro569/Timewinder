extends AnimatedSprite2D

# Set to second frame if it is future
func _process(delta):
	set_frame(get_node("/root/Node2D/Level/TileMap").get("future"))
	pass

extends AnimatedSprite2D

# Set to second frame if it is future
func _process(delta):
	var obj = get_node_or_null("/root/Node2D/Level/TileMap")
	if obj != null:
		set_frame(obj.get("future"))
	pass

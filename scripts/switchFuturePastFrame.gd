extends AnimatedSprite2D

# Set to second frame if it is future
func _process(delta):
	var actives = get_parent().get_parent().get("activators")
	var obj = get_node_or_null("/root/Node2D/Level/TileMap")
	if obj != null:
		if obj.get("future"):
			if actives != null:
				if actives > 0:
					set_frame(3)
				else:
					set_frame(1)
			else:
				set_frame(1)
		else:
			if actives != null:
				if actives > 0:
					set_frame(2)
				else:
					set_frame(0)
			else:
				set_frame(0)
	pass

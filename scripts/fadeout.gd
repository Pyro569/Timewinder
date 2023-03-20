extends ColorRect

func fadeout():
	var fadeoutRect = get_node("/root/Node2D/Effects/Fadeout")
	var animPlayer = get_node("/root/Node2D/Effects/AnimationPlayer")
	var screensize
	screensize = get_viewport_rect().size
	fadeoutRect.set_position(-(screensize/2))
	fadeoutRect.set_size(screensize*1000000)
	print("Playing fade animation")
	animPlayer.play("fade_to_black")
	print("Played fade animation")

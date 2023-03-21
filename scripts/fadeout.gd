extends ColorRect

var screensize

func _ready():
	var fadeoutRect = get_node("/root/Node2D/Effects/Fadeout")
	var animPlayer = get_node("/root/Node2D/Effects/AnimationPlayer")
	screensize = get_viewport_rect().size
	fadeoutRect.set_position(-(screensize/2))
	fadeoutRect.set_size(screensize*1000000)
	animPlayer.play_backwards("fade_to_black")

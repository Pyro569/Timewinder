extends Camera2D

var intended_x = 1152.0
var intended_y = 648.0


func _process(_delta):
	var viewport_size = get_viewport_rect().size
	var intended_aspect_ratio = intended_x / intended_y
	var viewport_aspect_ratio = viewport_size.x / viewport_size.y
	var new_scale = 1.0

	if intended_aspect_ratio > viewport_aspect_ratio:
		new_scale = viewport_size.x / intended_x
	else:
		new_scale = viewport_size.y / intended_y
		

	

	set_zoom(Vector2(new_scale, new_scale))

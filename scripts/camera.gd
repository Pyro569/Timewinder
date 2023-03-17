extends Camera2D

var intended_x = 1152.0
var intended_y = 648.0

func _process(delta):
	var player = get_node("/root/" + get_tree().current_scene.get_name() + "/Player/CharacterBody2D")
	var velocity = Vector2.ZERO
	var iterations = 1
	var viewport_size = get_viewport_rect().size
	var intended_aspect_ratio = intended_x / intended_y
	var viewport_aspect_ratio = viewport_size.x / viewport_size.y
	var scale = 1.0

	if intended_aspect_ratio > viewport_aspect_ratio:
		scale = viewport_size.x / intended_x
	else:
		scale = viewport_size.y / intended_y
		
	if player.velocity.x >= (1000*iterations):
		velocity.x -= 1000
		iterations = iterations - 1
	elif player.velocity.x >= (1000*iterations):
		velocity.x += 1000
		iterations = iterations + 1
	

	set_zoom(Vector2(scale, scale))

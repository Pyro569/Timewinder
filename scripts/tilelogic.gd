extends TileMap

var future_cam
var past_cam
var future = true
var time_travelling = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var cell_size = tile_set.tile_size
	for cell in get_used_cells_by_id(0, 7): # future cam
		future_cam = (cell + Vector2i(1, 1)) * cell_size
		get_node("/root/Node2D/Camera/Camera2D").position = future_cam
	for cell in get_used_cells_by_id(0, 5): # player start
		var player_size = Vector2i(get_node("/root/Node2D/Player/CharacterBody2D/CollisionShape2D").get_shape().get_rect().size)
		get_node("/root/Node2D/Player/CharacterBody2D").position = cell * cell_size + (cell_size - player_size) / 2
	for cell in get_used_cells_by_id(0, 6): # past cam
		past_cam = (cell + Vector2i(1, 1)) * cell_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("timeTravel"):
		if !time_travelling:
			time_travelling = true
			if future:
				future = false
				print("future")
				get_node("/root/Node2D/Camera/Camera2D").position = past_cam
				get_node("/root/Node2D/Player/CharacterBody2D").position += Vector2(past_cam - future_cam)
			else:
				future = true
				print("past")
				get_node("/root/Node2D/Camera/Camera2D").position = future_cam
				get_node("/root/Node2D/Player/CharacterBody2D").position += Vector2(future_cam - past_cam)
	else:
		time_travelling = false

extends TileMap

var future_cam
var past_cam
var future = true
var time_travelling = false

var timer = Timer.new()
var unixTime = 0

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
	for cell in get_used_cells_by_id(0, 4): # level end
		get_node("/root/Node2D/Level/MagnetLevelEnd").global_position = (Vector2(cell) + Vector2(-1, 0.5)) * Vector2(cell_size)
		print(Vector2(cell * cell_size))
		
	add_child(timer)
	timer.set_wait_time(1.0)
	timer.connect("timeout", _on_Timer_timeout)
	timer.start()
	
func _on_Timer_timeout():
	unixTime = unixTime + 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("timeTravel") and unixTime >= 2:
		if !time_travelling:
			time_travelling = true
			if future:
				future = false
				get_node("/root/Node2D/Camera/Camera2D").position = past_cam
				get_node("/root/Node2D/Player/CharacterBody2D").position += Vector2(past_cam - future_cam)
				unixTime = 0
			else:
				future = true
				get_node("/root/Node2D/Camera/Camera2D").position = future_cam
				get_node("/root/Node2D/Player/CharacterBody2D").position += Vector2(future_cam - past_cam)
				unixTime = 0
	elif unixTime < 2:
		#play the sound for not allowed to time travel
		time_travelling = false
	else:
		time_travelling = false

extends TileMap

var cell_size = tile_set.tile_size
var future_cam
var past_cam
var future = true
var time_travelling = false

var timer = Timer.new()
var unixTime = 3

var noTravel = preload("res://assets/sounds/effects/noTravel.wav")
var playnotravelsound = preload("res://assets/sounds/effects/noTravel.wav")
var pressed_time_travel_last_frame = false


var id_to_node = {
	4: "Level/MagnetLevelEnd",
	0: "Level/Box",
	3: "Level/Button"
}

var MAX_SIGNAL_LENGTH = 64
var activator_ids = [3]
var activatee_ids = [4]
var activators = {}
var activatees = {}
var signals = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# setup tilemap
	for id in id_to_node:
		for cell in get_used_cells_by_id(0, id):
			var parent_node = get_node("/root/Node2D/" + id_to_node[id])
			var new_node = parent_node.duplicate()
			parent_node.add_child(new_node)
			new_node.global_position = cell * cell_size
			new_node.scale /= parent_node.scale
			if activator_ids.has(id):
				activators[cell] = new_node
			if activatee_ids.has(id):
				activatees[cell] = new_node
	# edge-cases
	for cell in get_used_cells_by_id(0, 7): # future cam
		get_node("/root/Node2D/Camera/Camera2D").global_position = cell * cell_size
		future_cam = cell * cell_size
	for cell in get_used_cells_by_id(0, 6): # past cam
		past_cam = cell * cell_size
	for cell in get_used_cells_by_id(0, 5): # player start
		var player_size = Vector2i(get_node("/root/Node2D/Player/CharacterBody2D/CollisionShape2D").get_shape().get_rect().size)
		get_node("/root/Node2D/Player/CharacterBody2D").position = cell * cell_size + (cell_size - player_size) / 2
	# signals
	for activator_id in activator_ids:
		for cell in get_used_cells_by_id(0, activator_id):
			var signal_end = cell - Vector2i(MAX_SIGNAL_LENGTH, 0)
			var current_cell = cell
			while signal_end.x < current_cell.x:
				current_cell -= Vector2i(1, 0)
				if activatees.has(current_cell):
					signals[activators[cell]] = activatees[current_cell]
					break
					
	print(signals)
			
	
		
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
	elif unixTime < 2 and Input.is_action_pressed("timeTravel") and !pressed_time_travel_last_frame:
		# This executes the sound as soon and only once when the designetated key for time trabeling is pressed
		get_node("/root/Node2D/Camera/Camera2D/AudioStreamPlayer").stream = playnotravelsound
		get_node("/root/Node2D/Camera/Camera2D/AudioStreamPlayer").play()
		time_travelling = false
	else:
		time_travelling = false
	pressed_time_travel_last_frame = Input.is_action_pressed("timeTravel")

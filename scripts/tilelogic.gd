extends TileMap

signal to_future
signal to_past

var cell_size = tile_set.tile_size
var future_cam
var past_cam
var future = true

var timer = Timer.new()

# Time since scene has been loaded
var gameStartTime = Time.get_ticks_msec()

var unixTime = 3
var moved = false
var moved2 = false
var level1Bool = false

var timeTravels = 0

var noTravel = preload("res://assets/sounds/effects/noTravel.wav")
var playnotravelsound = preload("res://assets/sounds/effects/noTravel.wav")
var play_yes_travel_sounds = [preload("res://assets/sounds/effects/yesTravel1.wav")]

var screensize
var travelCounterNode
var travelCounterNode2

var konamied = false
var konamiedPart1
var konamiedPart2

var id_to_node = {
	4: "MagnetLevelEnd",
	0: "Box",
	3: "Button",
	8: "ConveyerBelts/ConvayerBeltDown",
	9: "ConveyerBelts/ConvayerBeltLeft",
	10: "ConveyerBelts/ConvayerBeltRight",
	11: "ConveyerBelts/ConvayerBeltUp",
	23: "NuclearWaste"
}

var MAX_SIGNAL_LENGTH = 64
var signal_arrows = [15, 14, 12, 13] # never eat soggy waffles
var tvect_arrows = [18, 19, 20, 21]
var tvect_endpoint_id = 22
var tvect_endpoints = []
var activator_ids = [3]
var activatee_ids = [4]
var activators = {}
var activatees = {}
var duplicants = []

func get_random_teleport_sound():
	# This is here incase we need more sfx for teleporting
	return play_yes_travel_sounds[0]

func resolve_signal(activator: Vector2i, direction: int, past_arrows = [], tvect = false):
	#print(activator, direction, past_arrows)
	past_arrows.append(activator)
	var direction_vect
	var direction_expression
	match direction:
		0:
			direction_vect = Vector2i(0, -MAX_SIGNAL_LENGTH)
			direction_expression = func(a, b): return a.y < b.y
		1:
			direction_vect = Vector2i(MAX_SIGNAL_LENGTH, 0)
			direction_expression = func(a, b): return a.x > b.x
		2:
			direction_vect = Vector2i(0, MAX_SIGNAL_LENGTH)
			direction_expression = func(a, b): return a.y > b.y
		3:
			direction_vect = Vector2i(-MAX_SIGNAL_LENGTH, 0)
			direction_expression = func(a, b): return a.x < b.x
	var signal_end = activator + direction_vect
	var current_cell = activator
	var arrows
	var layer
	var endpoints
	if tvect:
		arrows = tvect_arrows
		layer = 0
		endpoints = tvect_endpoints
	else:
		arrows = signal_arrows
		layer = 1
		endpoints = activatees
	#print(signal_end, current_cell, direction_expression.call(signal_end, current_cell), signal_end.x < current_cell.x)
	while direction_expression.call(signal_end, current_cell):
		current_cell += direction_vect / MAX_SIGNAL_LENGTH
		#print(current_cell)
		if endpoints.has(current_cell):
			if tvect:
				var tvects = []
				for i in range(past_arrows.size()):
					if i == past_arrows.size() - 1:
						tvects.append(Vector2(current_cell - past_arrows[i]) * Vector2(tile_set.tile_size))
						print(tvects, (current_cell - past_arrows[i]), tile_set.tile_size)
						return tvects
					else:
						tvects.append(Vector2(past_arrows[i + 1] - past_arrows[i]) * Vector2(tile_set.tile_size))
						print(tvects, (past_arrows[i + 1] - past_arrows[i]), tile_set.tile_size)
			else:
				return current_cell
		elif arrows.has(get_cell_source_id(layer, current_cell)):
			var arrow_direction = arrows.find(get_cell_source_id(layer, current_cell))
			if !past_arrows.has(current_cell): # prevent infinite loop
				return resolve_signal(current_cell, arrow_direction, past_arrows, tvect) # recursively go through every arrow
			else:
				#print("test")
				break

# Called when the node enters the scene tree for the first time.
func _ready():
	travelCounterNode = get_node("/root/Node2D/Effects/TravelCounter")
	travelCounterNode2 = get_node("/root/Node2D/Effects/TravelCounter2")
	
	travelCounterNode.text = "Travels: 0"
	travelCounterNode2.text = "Travels: 0"
	# setup tilemap
	for id in id_to_node:
		for cell in get_used_cells_by_id(1, id):
			var parent_node = get_node("/root/Node2D/Level/Duplicants/" + id_to_node[id])
			var new_node = parent_node.duplicate()
			duplicants.append(new_node)
			parent_node.add_sibling(new_node)
			new_node.init_pos = cell
			new_node.prev_pos = cell * cell_size
			new_node.global_position = cell * cell_size
			if activator_ids.has(id):
				activators[cell] = new_node
			if activatee_ids.has(id):
				activatees[cell] = new_node
	# required objects
	for cell in get_used_cells_by_id(1, 7): # future cam
		print(get_node("/root/Node2D"))
		get_node("/root/Node2D/Camera/Camera2D").global_position = cell * cell_size
		future_cam = cell * cell_size
	for cell in get_used_cells_by_id(1, 6): # past cam
		past_cam = cell * cell_size
	Globals.cam_delta = Vector2(past_cam - future_cam)
	for cell in get_used_cells_by_id(1, 5): # player start
		var player_size = Vector2i(get_node("/root/Node2D/Player/RigidBody2D/CollisionShape2D").get_shape().get_rect().size)
		get_node("/root/Node2D/Player/RigidBody2D").position = cell * cell_size + (cell_size - player_size) / 2
	# signals
	Globals.signals = {}
	for activator_id in activator_ids:
		for cell in get_used_cells_by_id(1, activator_id):
			var activatee = resolve_signal(cell, 3)
			if activatee != null:
				Globals.signals[activators[cell]] = activatees[activatee]
			else:
				Globals.signals[activators[cell]] = null
	print(Globals.signals)
	for activator in Globals.signals:
		if Globals.signals[activator] != null:
			print(Globals.signals[activator])
			Globals.signals[activator].activators = 0
	# time travel initial vectors
	for cell in get_used_cells_by_id(0, tvect_endpoint_id):
		tvect_endpoints.append(cell)
	for dupe in duplicants:
		var id = get_cell_source_id(0, dupe.init_pos)
		if tvect_arrows.has(id):
			dupe.travelvects = resolve_signal(dupe.init_pos, tvect_arrows.find(id), [], true)
			print(dupe.travelvects)
		if future:
			dupe.future()
		
	add_child(timer)
	timer.set_wait_time(1.0)
	timer.connect("timeout", _on_Timer_timeout)
	timer.start()
	
func _on_Timer_timeout():
	unixTime = unixTime + 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if get_node_or_null("/root/Node2D/Effects/arbitraryuselessnodethatnobodyshoulddeletetonotbreakgame"):
		travelCounterNode.visible = false
		travelCounterNode2.visible = false
	if get_node_or_null("/root/Node2D/Effects/Level1"):
		if moved == false:
			level1Bool = true
			travelCounterNode.text = "[W][A][S][D] to move John-E-VI"
			travelCounterNode2.text = "[W][A][S][D] to move John-E-VI"
			moved = true
		if Input.is_action_pressed("moveLeft") or Input.is_action_pressed("moveRight") or Input.is_action_pressed("moveUp") or Input.is_action_pressed("moveDown"):
			if moved == true:
				travelCounterNode.text = "[TAB] to reset level"
				travelCounterNode2.text = "[TAB] to reset level"
				moved2 = true
		if Input.is_action_pressed("moveLeft") or Input.is_action_pressed("moveRight") or Input.is_action_pressed("moveUp") or Input.is_action_pressed("moveDown"):
			if moved2 == true:
				travelCounterNode.text = "Reach the magnet to beat the level"
				travelCounterNode2.text = "Reach the magnet to beat the level"
	else:
		travelCounterNode.text = "Travels: " + str(timeTravels)
		travelCounterNode2.text = "Travels: " + str(timeTravels)
	if Input.is_action_just_pressed("timeTravel") and unixTime >= 2:
		if level1Bool == false:
			get_node("/root/Node2D/Camera/Camera2D/AudioStreamPlayer").stream = get_random_teleport_sound()
			get_node("/root/Node2D/Camera/Camera2D/AudioStreamPlayer").play()
			if future:
				future = false
				get_node("/root/Node2D/Camera/Camera2D").position = past_cam
				get_node("/root/Node2D/Player/RigidBody2D").position += Globals.cam_delta
				if konamied == false:
					unixTime = 0
				timeTravels = timeTravels + 1
				travelCounterNode.text = "Travels: " + str(timeTravels)
				travelCounterNode2.text = "Travels: " + str(timeTravels)
				for dupe in duplicants:
					dupe.past()
				to_past.emit()
			else:
				future = true
				get_node("/root/Node2D/Camera/Camera2D").position = future_cam
				get_node("/root/Node2D/Player/RigidBody2D").position -= Globals.cam_delta
				if konamied == false:
					unixTime = 0
				timeTravels = timeTravels + 1
				travelCounterNode.text = "Travels: " + str(timeTravels)
				travelCounterNode2.text = "Travels: " + str(timeTravels)
				for dupe in duplicants:
					dupe.future()
				to_future.emit()
		elif unixTime < 2 and Input.is_action_just_pressed("timeTravel"):
		# This executes the sound as soon and only once when the designetated key for time trabeling is pressed
			get_node("/root/Node2D/Camera/Camera2D/AudioStreamPlayer").stream = playnotravelsound
			get_node("/root/Node2D/Camera/Camera2D/AudioStreamPlayer").play()
	
	if unixTime >= 3:
		unixTime = 3
	
	if Input.is_action_just_pressed("konamiPart1"):
		konamiedPart1 = true
		print("Cheat code part 1 activated!!!!")
	if Input.is_action_just_pressed("konamiPart2") and konamiedPart1 == true:
		konamiedPart2 = true
		print("Cheat code part 2 activated!!!!")
	if Input.is_action_just_pressed("konamiPart3") and konamiedPart2 == true:
		konamied = true
		print("Cheat code successfully activated!!!!")
	
	

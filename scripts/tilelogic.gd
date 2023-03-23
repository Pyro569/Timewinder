extends TileMap

var cell_size = tile_set.tile_size
var future_cam
var past_cam
var future = true
var time_travelling = false

var timer = Timer.new()
var unixTime = 3

var timeTravels = 0

var noTravel = preload("res://assets/sounds/effects/noTravel.wav")
var playnotravelsound = preload("res://assets/sounds/effects/noTravel.wav")
var play_yes_travel_sounds = [preload("res://assets/sounds/effects/yesTravel1.wav")]

var screensize
var travelCounterNode
var travelCounterNode2

var pressed_time_travel_last_frame = false

var konamied = false
var konamiedPart1
var konamiedPart2

var id_to_node = {
	4: "Level/MagnetLevelEnd",
	0: "Level/Box",
	3: "Level/Button"
}

var MAX_SIGNAL_LENGTH = 64
var signal_arrows = [15, 14, 12, 13] # never eat soggy waffles
var activator_ids = [3]
var activatee_ids = [4]
var activators = {}
var activatees = {}

func get_random_teleport_sound():
	# This is here incase we need more sfx for teleporting
	return play_yes_travel_sounds[0]

func resolve_signal(activator: Vector2i, direction: int, past_arrows = []):
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
	#print(signal_end, current_cell, direction_expression.call(signal_end, current_cell), signal_end.x < current_cell.x)
	while direction_expression.call(signal_end, current_cell):
		current_cell += direction_vect / MAX_SIGNAL_LENGTH
		#print(current_cell)
		if activatees.has(current_cell):
			return current_cell
		elif signal_arrows.has(get_cell_source_id(0, current_cell)):
			var arrow_direction = signal_arrows.find(get_cell_source_id(0, current_cell))
			if !past_arrows.has(current_cell): # prevent infinite loop
				return resolve_signal(current_cell, arrow_direction, past_arrows) # recursively go through every arrow
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
	# required objects
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
			var activatee = resolve_signal(cell, 3)
			if activatee != null:
				Globals.signals[activators[cell]] = activatees[activatee]
			else:
				Globals.signals[activators[cell]] = null
					
	#print(Globals.signals)
		
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
		travelCounterNode.text = "[W][A][S][D] to move John-E-VI"
		travelCounterNode2.text = "[W][A][S][D] to move John-E-VI"
	else:
		travelCounterNode.text = "Travels: " + str(timeTravels)
		travelCounterNode2.text = "Travels: " + str(timeTravels)
	if Input.is_action_pressed("timeTravel") and unixTime >= 2:
		if !time_travelling:
			# You don't need to check if the time travel button is pressed for the first frame since
			# it will automatically go to the else if unix timeis less than 2
			# so this just plays the sfx
			get_node("/root/Node2D/Camera/Camera2D/AudioStreamPlayer").stream = get_random_teleport_sound()
			get_node("/root/Node2D/Camera/Camera2D/AudioStreamPlayer").play()
			
			time_travelling = true
			if future:
				future = false
				get_node("/root/Node2D/Camera/Camera2D").position = past_cam
				get_node("/root/Node2D/Player/CharacterBody2D").position += Vector2(past_cam - future_cam)
				if konamied == false:
					unixTime = 0
				timeTravels = timeTravels + 1
				travelCounterNode.text = "Travels: " + str(timeTravels)
				travelCounterNode2.text = "Travels: " + str(timeTravels)
			else:
				future = true
				get_node("/root/Node2D/Camera/Camera2D").position = future_cam
				get_node("/root/Node2D/Player/CharacterBody2D").position += Vector2(future_cam - past_cam)
				if konamied == false:
					unixTime = 0
				timeTravels = timeTravels + 1
				travelCounterNode.text = "Travels: " + str(timeTravels)
				travelCounterNode2.text = "Travels: " + str(timeTravels)
	elif unixTime < 2 and Input.is_action_pressed("timeTravel") and !pressed_time_travel_last_frame:
		# This executes the sound as soon and only once when the designetated key for time trabeling is pressed
		get_node("/root/Node2D/Camera/Camera2D/AudioStreamPlayer").stream = playnotravelsound
		get_node("/root/Node2D/Camera/Camera2D/AudioStreamPlayer").play()
		time_travelling = false
	else:
		time_travelling = false
	pressed_time_travel_last_frame = Input.is_action_pressed("timeTravel")
	
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


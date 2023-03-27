extends RigidBody2D

var next_pos = Vector2(0, 0)

func _physics_process(delta):
	set_linear_velocity(Vector2(0, 0))
	#while travelframes > 0:
	#	travelframes -= 1
	#	set_freeze_enabled(true)
	#if travelframes == 0 and freeze:
	#	set_freeze_enabled(false)
	
	# for testing purposes, not meant to be gameplay
	if Input.is_action_just_pressed("konamiPart1"):
		set_freeze_enabled(true)
	if Input.is_action_just_pressed("konamiPart2"):
		set_freeze_enabled(false)
		

func travel():
	pass
	
func _process(_delta):
	#print(position)
	pass

func _integrate_forces(state):
	if next_pos != Vector2(0, 0):
		#print("STATE: " + str(state.transform.origin), ", ", str(next_pos))
		state.transform.origin += next_pos
		next_pos = Vector2(0, 0)
		linear_velocity = Vector2.ZERO
		angular_velocity = 0.0
		#print("RESULT: " + str(state.transform.origin), ", ", str(next_pos))

#func _integrate_forces(state):
#	if teleport != Vector2(0, 0):
#		print(position)
#		print("BOXTELE: ", teleport)
#		var t = state.get_transform()
#		t.origin.x = teleport.x / 2
#		t.origin.y = teleport.y / 2
#		state.set_transform(t)
#		teleport = Vector2(0, 0)
#		print(position)

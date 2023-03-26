extends RigidBody2D

var teleport = Vector2(0, 0)

func _physics_process(delta):
	set_linear_velocity(Vector2(0, 0))
	

func travel():
	pass
	
func _process(_delta):
	#print(position)
	pass
	
func _integrate_forces(state):
	if teleport != Vector2(0, 0):
		print(position)
		print("BOXTELE: ", teleport)
		var t = state.get_transform()
		t.origin.x = teleport.x
		t.origin.y = teleport.y
		state.set_transform(t)
		teleport = Vector2(0, 0)
		print(position)

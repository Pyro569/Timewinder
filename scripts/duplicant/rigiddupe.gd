extends "res://scripts/duplicant.gd"

func future():
	print(get_node("RigidBody2D").position)
	print(position)
	get_node("RigidBody2D").travelframes = 5
	for vect in travelvects:
		position += vect
	position -= Globals.cam_delta
	print(position)
	
func past():
	print(get_node("RigidBody2D").position)
	print(position)
	get_node("RigidBody2D").travelframes = 5
	for vect in travelvects:
		position -= vect
	position += Globals.cam_delta
	print(position)

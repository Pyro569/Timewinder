extends "res://scripts/duplicant.gd"

func future():
	var new_delta = Vector2.ZERO
	for vect in travelvects:
		new_delta += vect
	new_delta -= Globals.cam_delta
	print(new_delta)
	get_node("RigidBody2D").next_pos = new_delta
	
func past():
	var new_delta = Vector2.ZERO
	for vect in travelvects:
		new_delta -= vect
	new_delta += Globals.cam_delta
	print(new_delta)
	get_node("RigidBody2D").next_pos = new_delta

extends "res://scripts/duplicant.gd"

func future():
	var new_delta = Vector2.ZERO
	for vect in travelvects:
		new_delta += vect
	new_delta -= Globals.cam_delta
	#print(new_delta)
	prev_pos = get_node("RigidBody2D").global_position + new_delta
	#print("NEXTPOS: ", str(prev_pos), str(get_node("RigidBody2D").global_position))
	get_node("RigidBody2D").next_pos = new_delta
	
func past():
	#print("PREVPOS: ", str(prev_pos), str(get_node("RigidBody2D").global_position))
	travelvects.append(get_node("RigidBody2D").global_position - prev_pos)
	var new_delta = Vector2.ZERO
	for vect in travelvects:
		new_delta -= vect
	new_delta += Globals.cam_delta
	#print(new_delta)
	get_node("RigidBody2D").next_pos = new_delta

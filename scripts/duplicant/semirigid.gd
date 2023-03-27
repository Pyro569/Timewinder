extends "res://scripts/duplicant.gd"

# rigid in the past, area2d in the future

func future():
	var new_delta = Vector2.ZERO
	for vect in travelvects:
		new_delta += vect
	new_delta -= Globals.cam_delta
	print(new_delta)
	$Area2D.position = $RigidBody2D.position + new_delta
	
func past():
	pass

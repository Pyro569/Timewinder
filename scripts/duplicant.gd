extends Node2D

var init_pos: Vector2i
var prev_pos: Vector2
var travelvects = []

func future():
	print("yes: ", name)
	for vect in travelvects:
		position += vect
	position -= Globals.cam_delta
	
func past():
	print("yes: ", name)
	for vect in travelvects:
		position -= vect
	position += Globals.cam_delta

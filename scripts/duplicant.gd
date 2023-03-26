extends Node2D

var init_pos: Vector2i
var travelvects = []

func future():
	for vect in travelvects:
		position += vect
	position -= Globals.cam_delta
	
func past():
	for vect in travelvects:
		position -= vect
	position += Globals.cam_delta

extends Node2D

var init_pos: Vector2i
var travelvects = []

func _process(delta):
	#(get_node("RigidBody2D").position)
	pass

func future():
	var pos_delta = Vector2(0, 0)
	for vect in travelvects:
		pos_delta += vect
	pos_delta -= Globals.cam_delta
	print(name, pos_delta)
	get_node("RigidBody2D").teleport = pos_delta
	print(get_node("RigidBody2D").position)
	
func past():
	var pos_delta = Vector2(0, 0)
	for vect in travelvects:
		pos_delta -= vect
	pos_delta += Globals.cam_delta
	print(name, pos_delta)
	get_node("RigidBody2D").teleport = pos_delta

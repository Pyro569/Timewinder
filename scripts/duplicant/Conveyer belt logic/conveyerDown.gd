extends Area2D

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


var speed = 35

func modifyBodySpeed(body, movement):
	body.set("constant_force", movement * speed)

func _process(_delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if(body.get("constant_force") != null):
			if(body.get("constant_force").x == 0 and body.get("constant_force").y == 0):
				modifyBodySpeed(body, Vector2(0, 1))

func _on_body_exited(body):
	if(body.get("constant_force") != null):
		modifyBodySpeed(body, Vector2(0, 0))

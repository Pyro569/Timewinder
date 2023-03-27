extends Area2D

var speed = 35

func modifyBodySpeed(body, movement):
	body.set("constant_force", movement * speed)

func _process(_delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		modifyBodySpeed(body, Vector2(1, 0))

func _on_body_exited(body):
	modifyBodySpeed(body, Vector2(0, 0))

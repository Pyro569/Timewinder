class_name Player
extends AnimatableBody2D

var velocity = Vector2.ZERO

var maxSpeed = 350

func respawn():
	pass

func _process(delta):
	var new_pos = position
	if Input.is_action_pressed("moveUp"):
		new_pos.y -= 1
	if Input.is_action_pressed("moveDown"):
		new_pos.y += 1
	if Input.is_action_pressed("moveLeft"):
		new_pos.x -= 1
	if Input.is_action_pressed("moveRight"):
		new_pos.x += 1
	position = new_pos

class_name Player
extends AnimatableBody2D

var velocity = Vector2.ZERO

var maxSpeed = 350

func respawn():
	pass

func _process(delta):
	if Input.is_action_pressed("moveUp"):
		position.y -= 10
	elif Input.is_action_pressed("moveDown"):
		position.y += 10
	if Input.is_action_pressed("moveLeft"):
		position.x -= 10
	elif Input.is_action_pressed("moveRight"):
		position.x += 10
	

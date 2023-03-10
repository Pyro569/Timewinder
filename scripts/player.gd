class_name Player
extends AnimatableBody2D

var velocity = Vector2.ZERO

var maxSpeed = 350

func respawn():
	pass

var processing = false

func _process(delta):
	if !processing:
		processing = true
		var new_pos = position
		if Input.is_action_pressed("moveUp"):
			new_pos.y -= 5
		if Input.is_action_pressed("moveDown"):
			new_pos.y += 5
		if Input.is_action_pressed("moveLeft"):
			new_pos.x -= 5
		if Input.is_action_pressed("moveRight"):
			new_pos.x += 5
		if position != new_pos:
			position = new_pos
			print(str(new_pos) + str(int(Input.is_action_pressed("moveUp"))) + str(int(Input.is_action_pressed("moveDown"))) + str(int(Input.is_action_pressed("moveLeft"))) + str(int(Input.is_action_pressed("moveRight"))))
		processing = false

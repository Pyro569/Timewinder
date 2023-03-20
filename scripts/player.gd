class_name Player
extends CharacterBody2D

@export var speed = 200
func get_input():
	var input_direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	velocity = input_direction * speed

func _physics_process(_delta):
	#print(position)
	get_input()
	if velocity.x != 0 or velocity.y != 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	move_and_slide()



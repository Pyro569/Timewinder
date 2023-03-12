class_name Player
extends CharacterBody2D

@export var speed = 200

func get_input():
	var input_direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	if velocity.x < 0:
		$CollisionShape2D/AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$CollisionShape2D/AnimatedSprite2D.flip_h = false
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	$CollisionShape2D/AnimatedSprite2D.play()
	move_and_slide()

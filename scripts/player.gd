class_name Player
extends CharacterBody2D

@export var speed = 200
var i = 0
func get_input():
	var input_direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	if velocity.x < 0:
		$CollisionShape2D/AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$CollisionShape2D/AnimatedSprite2D.flip_h = false
	elif velocity.x == 0 && i == 0:
		var duplicated_node = self.duplicate()
		self.add_child(duplicated_node)
		i += 1
	velocity = input_direction * speed

func _physics_process(delta):
	#print(position)
	get_input()
	if velocity.x != 0 or velocity.y != 0:
		$CollisionShape2D/AnimatedSprite2D.play()
	else:
		$CollisionShape2D/AnimatedSprite2D.stop()
	move_and_slide()



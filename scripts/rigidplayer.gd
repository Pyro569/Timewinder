class_name Player

extends RigidBody2D

# This is now a RigidBody2D so other rigidbody collision will work

func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(4)

@export var speed = 200
func get_input():
	var input_direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	if get_linear_velocity().x < 0:
		$AnimatedSprite2D.flip_h = true
	elif get_linear_velocity().x > 0:
		$AnimatedSprite2D.flip_h = false
	set_linear_velocity(input_direction * speed)

func _physics_process(_delta):
	#print(position)
	get_input()
	if get_linear_velocity().x != 0 or get_linear_velocity().y != 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	if Input.is_action_pressed("reload"):
		get_tree().reload_current_scene()
	#print("\n" + str(get_colliding_bodies()) + "\n")

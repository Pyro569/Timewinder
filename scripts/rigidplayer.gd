class_name Player

extends RigidBody2D

var stop = false

# This is now a RigidBody2D so other rigidbody collision will work

func _ready():
	Globals.muted = false
	set_contact_monitor(true)
	set_max_contacts_reported(4)

@export var speed = 200
func get_input():
	if !stop:
		freeze = false
		var input_direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
		if input_direction.x < 0:
			$AnimatedSprite2D.flip_h = true
		elif input_direction.x > 0:
			$AnimatedSprite2D.flip_h = false
		set_linear_velocity(input_direction * speed)
	else:
		set_linear_velocity(Vector2.ZERO)
		freeze = true

func _physics_process(_delta):
	#print(position)
	get_input()
	if get_linear_velocity().x != 0 or get_linear_velocity().y != 0:
		if(get_linear_velocity().y > 0):
			$AnimatedSprite2D.frame = 2
		elif(get_linear_velocity().y < 0):
			$AnimatedSprite2D.frame = 1
		else:
			$AnimatedSprite2D.frame = 0
	#else:
	#	$AnimatedSprite2D.stop()
	if Input.is_action_pressed("reload"):
		get_tree().reload_current_scene()
	#print("\n" + str(get_colliding_bodies()) + "\n")


func _on_tile_map_to_future():
	pass # Replace with function body.

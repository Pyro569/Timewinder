extends RigidBody2D

# TODO:
# Box probably shouldn't be able to be moved diagonally

func _physics_process(delta):
	set_linear_velocity(Vector2(0, 0))

extends Area2D

func _on_body_entered(body):
	print("ENTER: ", body.get_name())
	Globals.signals[self].enabled = true

func _on_body_exited(body):
	print("EXIT: ", body.get_name())
	Globals.signals[self].enabled = false

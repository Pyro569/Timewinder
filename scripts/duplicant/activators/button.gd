extends Area2D

func _on_body_entered(body):
	print("ENTER: ", body.get_name())
	print(Globals.signals)
	get_parent().activate()

func _on_body_exited(body):
	print("EXIT: ", body.get_name())
	get_parent().deactivate()

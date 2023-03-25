extends Area2D

func _on_body_entered(body):
	print("ENTER: ", body.get_name())
	print(Globals.signals)
	$AnimatedSprite2D.frame = 3
	get_parent().activate()

func _on_body_exited(body):
	print("EXIT: ", body.get_name())
	$AnimatedSprite2D.frame = 0
	get_parent().deactivate()

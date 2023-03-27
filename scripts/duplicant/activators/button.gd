extends Area2D

func _on_body_entered(body):
	print("ENTER: ", body.get_name())
	print(Globals.signals)
	$AnimatedSprite2D.frame = 0
	$AnimatedSprite2D.frame = 1
	$AnimatedSprite2D.frame = 2
	$AnimatedSprite2D.frame = 3
	get_parent().activate()

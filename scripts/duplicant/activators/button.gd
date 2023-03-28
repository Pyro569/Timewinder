extends Area2D

var spaghettiframes = 0

func _on_body_entered(body):
	if spaghettiframes > 30:
		$AnimatedSprite2D.play()
		get_parent().activate()

func _on_body_exited(body):
	$AnimatedSprite2D.play_backwards()
	get_parent().deactivate()

func _process(delta):
	spaghettiframes += 1

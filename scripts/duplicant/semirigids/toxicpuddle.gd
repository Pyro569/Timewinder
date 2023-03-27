extends Area2D

func _ready():
	$AnimatedSprite2D.play()

func _on_body_entered(body):
	if body.get_parent().name == "Player":
		get_tree().reload_current_scene()

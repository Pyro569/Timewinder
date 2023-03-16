extends Area2D

func _on_body_entered(body):
	if body.is_class("CharacterBody2D"):
		print("res://scenes/level" + str(int(get_tree().get_current_scene().get_name().substr(-1)) + 1))
		get_tree().change_scene("res://scenes/level" + str(int(get_tree().get_current_scene().get_name().substr(-1)) + 1))

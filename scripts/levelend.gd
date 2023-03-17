extends Area2D

func _on_body_entered(body):
	if body.is_class("CharacterBody2D"):
		var scene_name = get_tree().current_scene.get_name()
		get_tree().change_scene_to_file("res://scenes/level" + str(int(scene_name.substr(len(str(scene_name)) - 1)) + 1) + ".tscn")

extends Area2D

func _on_body_entered(body):
	if body.is_class("CharacterBody2D"):
		var scene_name = "res://scenes/level10.tscn"
		var new_scene = "res://scenes/level" + str(int(scene_name.substr(5, len(scene_name) - 5)) + 1) + ".tscn"
		print(new_scene)
		get_tree().change_scene_to_file(new_scene)

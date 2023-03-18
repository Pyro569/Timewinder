extends Area2D

func _on_body_entered(body):
	if body.is_class("CharacterBody2D"):
		var scene_name = str(get_tree().current_scene.scene_file_path)
		print("res://scenes/level" + str(int(scene_name.substr(len(scene_name) - 6, len(scene_name) - 5)) + 1) + ".tscn")
		get_tree().change_scene_to_file("res://scenes/level" + str(int(scene_name.substr(len(scene_name) - 6, len(scene_name) - 5)) + 1) + ".tscn")

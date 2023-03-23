extends Area2D

var enabled = true

func _on_body_entered(body):
	print(body.get_name())
	if body.get_name() == "CharacterBody2D" and enabled:
		var scene_name = str(get_tree().current_scene.scene_file_path)
		var new_scene = "res://scenes/level" + str(int(scene_name.substr(5, len(scene_name) - 5)) + 1) + ".tscn"
		get_tree().change_scene_to_file(new_scene)

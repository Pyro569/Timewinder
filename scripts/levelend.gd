extends Area2D

func _on_body_entered(body):
	if body.is_class("CharacterBody2D"):
		var scene_name = str(get_tree().current_scene.scene_file_path)
		var new_scene = "res://scenes/level" + str(int(scene_name.substr(5, len(scene_name) - 5)) + 1) + ".tscn"
		get_tree().change_scene_to_file(new_scene)


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	pass # Replace with function body.

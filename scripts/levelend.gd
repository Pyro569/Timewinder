extends Area2D

func _on_body_entered(body):
	if body.is_class("CharacterBody2D"):
		print("Collided")
		get_tree().change_scene_to_file("res://scenes/level2.tscn")


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	pass # Replace with function body.

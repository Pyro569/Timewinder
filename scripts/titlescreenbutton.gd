extends Node

func _on_pressed():
	get_tree().change_scene_to_file("res://scenes/level1.tscn")
	
func _physics_process(_delta):
	if Input.is_action_pressed("space"):
		get_tree().change_scene_to_file("res://scenes/level1.tscn")

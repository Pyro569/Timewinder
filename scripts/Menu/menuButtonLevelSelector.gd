extends Button


# Called when the node enters the scene tree for the first time.
func _on_button_down():
	Globals.levelPlayerIsOn = 0
	get_tree().change_scene_to_file("res://scenes/titlescreen.tscn")

extends Button

func _on_button_down():
	Globals.levelPlayerIsOn += 1
	get_tree().change_scene_to_file("res://scenes/level" + str(Globals.levelPlayerIsOn + 1) + ".tscn")
	pass # Replace with function body.

extends Button

func nextLevel():
	get_tree().change_scene_to_file("res://scenes/level" + str(Globals.levelPlayerIsOn + 1) + ".tscn")

func _on_button_down():
	print(str(Globals.levelPlayerIsOn + 1))
	nextLevel()
	pass # Replace with function body.

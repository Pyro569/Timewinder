extends Button

func nextLevel():
	get_tree().change_scene_to_file("res://scenes/level" + str(Globals.levelPlayerIsOn + 1) + ".tscn")

func _on_button_down():
	Globals.levelPlayerIsOn += 1
	nextLevel()
	pass # Replace with function body.

func _physics_process(_delta):
	if Input.is_action_pressed("space"):
		nextLevel()

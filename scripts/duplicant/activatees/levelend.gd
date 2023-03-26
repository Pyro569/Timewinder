extends Area2D

func _on_body_entered(body):
	if body.get_parent().get_name() == "Player" and get_parent().activators > 0:
		print(get_node("/root/Node2D/Level/TileMap").get("bestTime"))
		# Updates best times to the globals list with this
		Globals.thisLevels.endLevelCheck(get_node("/root/Node2D/Level/TileMap").get("timeTravels"), (Time.get_ticks_msec() - get_node("/root/Node2D/Level/TileMap").get("gameStartTime")) / 1000)
		var new_scene = "res://scenes/levelWin.tscn"
		get_tree().change_scene_to_file(new_scene)

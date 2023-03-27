extends Area2D

var won = false
var done = false

func _on_body_entered(body):
	if body.get_parent().get_name() == "Player" and get_parent().activators > 0:
		get_node("/root/Node2D/Player/RigidBody2D").stop = true
		won = true
	

func _process(_delta):
	var tilemap = get_node("/root/Node2D/Level/TileMap")
	if won:
		var current_cam
		if tilemap.future:
			current_cam = tilemap.future_cam.y
		else:
			current_cam = tilemap.past_cam.y
		print("endmagnet: ", str(current_cam), str($AnimatedSprite2D.position.y))
		if $AnimatedSprite2D.position.y >= current_cam + 324:
			$AnimatedSprite2D.position.y -= 10
			get_node("/root/Node2D/Player/RigidBody2D/AnimatedSprite2D").position = $AnimatedSprite2D.position - Vector2(75, -275)
		else:
			won = false
			done = true
	elif done:
		done = false
		print(get_node("/root/Node2D/Level/TileMap").get("bestTime"))
		# Updates best times to the globals list with this
		Globals.thisLevels.endLevelCheck(get_node("/root/Node2D/Level/TileMap").get("timeTravels"), (Time.get_ticks_msec() - get_node("/root/Node2D/Level/TileMap").get("gameStartTime")) / 1000)
		var new_scene = "res://scenes/levelWin.tscn"
		get_tree().change_scene_to_file(new_scene)

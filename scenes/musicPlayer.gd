extends AudioStreamPlayer

var last_frame_muted = false

# kind of dumb to call every frame but i don't know how to do it otherwise
func _process(_delta):
	if(Globals.muted):
		set_volume_db(-1000.0)
	else:
		set_volume_db(-25.0)
		if(last_frame_muted):
			# If you turn on audio right after, restart song
			play()
	last_frame_muted = Globals.muted
	pass

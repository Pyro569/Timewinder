extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO: Center text
	Globals.muted = true
	if(Globals.levelPlayerIsOn == Globals.levelsCount - 1):
		"Final level Complete! You've escaped the lab!"
	else:
		text = Globals.thisLevels.getCurrentLevel().name + " Complete!"
	pass # Replace with function body.

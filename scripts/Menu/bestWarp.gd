extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Best Warps: " + str(Globals.thisLevels.getCurrentLevel().warps) + " times"
	pass # Replace with function body.

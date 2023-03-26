extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Best Time: " + str(Globals.thisLevels.getCurrentLevel().timeToComplete) + " sec"
	pass # Replace with function body.

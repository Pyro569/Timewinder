extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO: Center text
	Globals.muted = true
	text = Globals.thisLevels.getCurrentLevel().name + " Complete!"
	pass # Replace with function body.

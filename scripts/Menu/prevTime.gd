extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Time: " + str(Globals.prevTime) + " sec"
	pass # Replace with function body.

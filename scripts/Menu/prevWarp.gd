extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Warps: " + str(Globals.prevWarps) + " times"
	pass # Replace with function body.

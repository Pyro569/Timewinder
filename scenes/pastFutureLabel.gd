extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(get_node("/root/Node2D/Level/TileMap").get("future")):
		text = "FUTURE"
	else:
		text = "PAST"
	pass

extends TileMap

var cell_size = 64

# Called when the node enters the scene tree for the first time.
func _ready():
	var camerapos = get_parent().get_parent().get_node("Camera/Camera2D").position
	print(camerapos)
	for cell in get_used_cells_by_id(0, 7):
		print(cell)
		get_parent().get_parent().get_node("Camera/Camera2D").position = Vector2i((cell.x) * cell_size, (cell.y + 2.25) * cell_size)
	print(get_parent().get_parent().get_node("Camera/Camera2D").position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

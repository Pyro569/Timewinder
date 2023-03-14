extends TileMap

@export var cell_size = 64

# Called when the node enters the scene tree for the first time.
func _ready():
	for cell in get_used_cells_by_id(0, 7): # future cam
		get_node("/root/Node2D/Camera/Camera2D").position = (cell + Vector2i(1, 1)) * cell_size
	for cell in get_used_cells_by_id(0, 5): # player start
		get_node("/root/Node2D/Player/CharacterBody2D").position = (cell + Vector2i(1, 1)) * cell_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

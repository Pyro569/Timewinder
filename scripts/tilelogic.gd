extends TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	var cell_size = tile_set.tile_size
	for cell in get_used_cells_by_id(0, 7): # future cam
		get_node("/root/Node2D/Camera/Camera2D").position = (cell + Vector2i(1, 1)) * cell_size
	for cell in get_used_cells_by_id(0, 5): # player start
		var player_size = Vector2i(get_node("/root/Node2D/Player/CharacterBody2D/CollisionShape2D").get_shape().get_rect().size)
		get_node("/root/Node2D/Player/CharacterBody2D").position = cell * cell_size + (cell_size - player_size) / 2
	for cell in get_used_cells_by_id(0, 6): # past cam
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

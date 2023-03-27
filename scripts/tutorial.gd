extends Node

var tutorial_node
var tutorial_node2
var moved = false
var timewinded = false


# Called when the node enters the scene tree for the first time.
func _ready():
	tutorial_node = get_node("/root/Node2D/Effects/Tutorial")
	tutorial_node2 = get_node("/root/Node2D/Effects/Tutorial2")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("timeTravel"):
		tutorial_node.text = "[TAB] to reset level if stuck"
		tutorial_node2.text = "[TAB] to reset level if stuck"

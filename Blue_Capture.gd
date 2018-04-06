extends Node2D


var type
var grid

func _ready():
	grid = get_parent()
	type = grid.CAPTURE_B
	set_physics_process(true)


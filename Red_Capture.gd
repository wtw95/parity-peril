extends Node2D


var type
var grid

func _ready():
	grid = get_parent()
	type = grid.CAPTURE_R
	set_physics_process(true)


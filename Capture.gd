extends Node2D

# class member variables go here, for example:
var type
var grid


func _ready():
	grid = get_parent()
	type = grid.CAPTURE_N
	set_physics_process(true)





extends Node2D

# class member variables go here, for example:
var type
var grid


func _ready():
	grid = get_parent()
	type = grid.CAPTURE_N
	set_physics_process(true)

func bluecapture():
	get_node("Sprite").set_color("blue")
	type = grid.CAPTURE_B
	
func redcapture():
	get_node("Sprite").set_color("red")
	type = grid.CAPTURE_R



extends Node2D

# class member variables go here, for example:
var type
var grid

func _ready():
	grid = get_parent()
	type = grid.CAPTURE_R
	set_physics_process(true)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

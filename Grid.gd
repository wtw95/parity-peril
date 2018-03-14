extends TileMap

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2

var grid_size = Vector2(8,6)
var grid = []

onready var Capture = preload("res://Capture.tscn")

func _ready():
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
	var cap_positions = []
	cap_positions.append(Vector2(1,3))
	cap_positions.append(Vector2(1,4))
	cap_positions.append(Vector2(3,2))
	cap_positions.append(Vector2(4,5))
	cap_positions.append(Vector2(5,5))
	cap_positions.append(Vector2(6,2))
	cap_positions.append(Vector2(8,3))
	cap_positions.append(Vector2(8,4))
	
	for pos in cap_positions:
		var new_capture = Capture.instance()
		new_capture.set_position(map_to_world(pos))
		
		add_child(new_capture)
	pass

func start():
	pass

func is_cell_vacant():
	pass

func update_child_pos(child, new_pos, direction):
	pass

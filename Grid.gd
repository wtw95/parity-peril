extends TileMap

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2
enum ENTITY_TYPES {PLAYER, CAPTURE}
var grid_size = Vector2(8,6)
var grid = []

onready var Capture = preload("res://Capture.tscn")

func _ready():
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
	var cap_positions = []
	cap_positions.append(Vector2(0,2))
	cap_positions.append(Vector2(0,3))
	cap_positions.append(Vector2(2,1))
	cap_positions.append(Vector2(3,4))
	cap_positions.append(Vector2(4,4))
	cap_positions.append(Vector2(5,1))
	cap_positions.append(Vector2(7,2))
	cap_positions.append(Vector2(7,3))
	
	for pos in cap_positions:
		var new_capture = Capture.instance()
		new_capture.set_position(map_to_world(pos) + half_tile_size)
		grid[pos.x][pos.y] = CAPTURE
		add_child(new_capture)
	pass

func start():
	pass

func is_cell_vacant(pos, direction):
	var grid_pos = world_to_map(pos) + direction
	
	if grid_pos.x < grid_size.x and grid_pos.x > 0:
		if grid_pos.y < grid_size.y and grid_pos.y > 0:
			return true if grid[grid_pos.x][grid_pos.y] == null or CAPTURE else false
	return false
	


func update_child_pos(child_node):
	var grid_pos = world_to_map(child_node.get_pos())
	print(grid_pos)
	grid[grid_pos.x][grid_pos.y] == null
	
	var new_grid_pos = grid_pos + child_node.direction
	grid[new_grid_pos.x][new_grid_pos.y] = child_node.type
	
	var target_pos = map_to_world(new_grid_pos) + half_tile_size
	return target_pos


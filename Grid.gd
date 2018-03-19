extends TileMap

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2
enum ENTITY_TYPES {PLAYER, PLAYER2, CAPTURE_N, CAPTURE_R, CAPTURE_B}
var grid_size = Vector2(8,6)
var grid = []

onready var Capture = preload("res://Capture.tscn")
onready var Capture_B = preload("res://Blue_Capture.tscn")
onready var Capture_R = preload("res://Red_Capture.tscn")

func _ready():
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
	
	var Player = get_node("Player")
	var start_pos = update_child_pos(Player)
	Player.set_position(start_pos)
	
	var Player2 = get_node("Player2")
	var start_pos2 = update_child_pos(Player2)
	Player2.set_position(start_pos2)
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
		grid[pos.x][pos.y] = CAPTURE_N
		add_child(new_capture)
		grid[0][0] = null

func start():
	pass

func is_cell_vacant(pos, direction):
	var grid_pos = world_to_map(pos) + direction
	
	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			return true if grid[grid_pos.x][grid_pos.y] == null else false
	return false
	

func bluecap():
	var pos_B = $Player.new_pos_B
	if pos_B == Vector2(0,2) or Vector2(0,3) or Vector2(2,1) or Vector2(3,4) or Vector2(4,4) or Vector2(5,1) or Vector2(7,2) or Vector2(7,3):
		var new_capture_B = Capture_B.instance()
		new_capture_B.set_position(map_to_world(pos_B) + half_tile_size)
		grid[pos_B.x][pos_B.y] = CAPTURE_B
		add_child(new_capture_B)

func redcap():
	var pos_R = $Player2.new_pos
	if pos_R == Vector2(0,2) or Vector2(0,3) or Vector2(2,1) or Vector2(3,4) or Vector2(4,4) or Vector2(5,1) or Vector2(7,2) or Vector2(7,3):
		var new_capture_R = Capture_R.instance()
		new_capture_R.set_position(map_to_world(pos_R) + half_tile_size)
		grid[pos_R.x][pos_R.y] = CAPTURE_R
		add_child(new_capture_R)

func update_child_pos(child_node):
	
	var grid_pos = world_to_map(child_node.get_position())
	print(grid_pos)
	grid[grid_pos.x][grid_pos.y] = null
	
	var new_grid_pos = grid_pos + child_node.direction
	grid[new_grid_pos.x][new_grid_pos.y] = child_node.type
	
	var target_pos = map_to_world(new_grid_pos) + half_tile_size
	return target_pos


extends TileMap

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2

var grid_size = Vector2(8,6)
var grid = []



func _ready():
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
		
	pass

func start():
	pass

#func is_cell_vacant():
	
#func update_child_pos(child, new_pos, direction):
#func _process(delta):
#	# Called every frame. Delta is time since last frame. 
#	# Update game logic here.
#	pass
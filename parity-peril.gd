extends Node

# class member variables go here, for example:
# var b = "textvar"
var click_pos
var grid



func _ready():
	grid = $Grid
	setboard()

func _input(event):
	
	if event.is_action_pressed("left_click"):
		click_pos = grid.world_to_map(event.position)
	#	print("Mouse Click to select at: ", click_pos)
		if grid.grid[click_pos.x][click_pos.y] == grid.PLAYER2:
			print("PLAYER2")
			deselect()
		elif grid.grid[click_pos.x][click_pos.y] == grid.PLAYER:
			print("PLAYER")
			deselect()
		elif grid.grid[click_pos.x][click_pos.y] == null:
			print("Nothing!")
			deselect()
			
		#grid.grid[0][0] = null
	#if event.is_action_released("left_click"):
	#	click_pos = grid.world_to_map(event.position)
	#	print("Mouse Click to move at: ", click_pos)

func setboard():
	grid.setcaptures()
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func deselect():
	$Grid/Odd_A.is_selected = false
	$Grid/Odd_B.is_selected = false
	$Grid/Odd_C.is_selected = false
	$Grid/Even_A.is_selected = false
	$Grid/Even_B.is_selected = false
	$Grid/Even_C.is_selected = false
	
func print_board_state():
	print("Current player: ", global.current_player_color)
	print("Selected pos: ", global.selected_piece_pos)
	print("Selected name: ", global.selected_piece_name)
	if global.selected_piece_name != "None":
		print("Has normal moves: ", has_normal_moves(global.selected_piece_name))
		print("Has capture moves: ", has_capture_moves(global.selected_piece_name))
	for i in range(8):
		var state_line = ""
		for j in range(6):
			if j == global.selected_piece_pos.x and i == global.selected_piece_pos.y:
				state_line += "(" + global.state[j][i] + ")\t"
			else:
				state_line += global.state[j][i] + "\t"
		print(state_line)
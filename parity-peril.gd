extends Node


var click_pos
var grid



func _ready():
	global.game_active = true
	grid = $Grid
	setboard()

func _input(event):
	
	if event.is_action_pressed("left_click"):
		click_pos = grid.world_to_map(event.position)
	#	print("Mouse Click to select at: ", click_pos)
		if click_pos.x <=7 and click_pos.y <=5:
			if grid.grid[click_pos.x][click_pos.y] == grid.PLAYER2:
				print("PLAYER2")
				deselect()
			elif grid.grid[click_pos.x][click_pos.y] == grid.PLAYER:
				print("PLAYER")
				deselect()
			elif grid.grid[click_pos.x][click_pos.y] == null:
				print("Nothing!")
				deselect()
		
	if event.is_action_pressed("ui_cancel"):
		get_tree().reload_current_scene()

func setboard():
	grid.setcaptures()

func restart():
	grid.setcaptures()
	grid.setpositions()
func deselect():
	$Grid/Odd_A.is_selected = false
	$Grid/Odd_B.is_selected = false
	$Grid/Odd_C.is_selected = false
	$Grid/Even_A.is_selected = false
	$Grid/Even_B.is_selected = false
	$Grid/Even_C.is_selected = false
	$Grid/Odd_A/capture_roll.set_text("")
	$Grid/Odd_B/capture_roll.set_text("")
	$Grid/Odd_C/capture_roll.set_text("")
	$Grid/Even_A/capture_roll.set_text("")
	$Grid/Even_B/capture_roll.set_text("")
	$Grid/Even_C/capture_roll.set_text("")

func deathcheck():
	if $Grid/Odd_A.is_dead and $Grid/Odd_B.is_dead and $Grid/Odd_C.is_dead:
		global.game_active = false
		get_node("Grid").get_node("Victory Text").redvictory()
	elif $Grid/Even_A.is_dead and $Grid/Even_B.is_dead and $Grid/Even_C.is_dead:
		global.game_active = false
		get_node("Grid").get_node("Victory Text").bluevictory()
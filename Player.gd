extends KinematicBody2D
var direction = Vector2()
const MAX_SPEED = 4000

var speed = 0
var velocity = Vector2()

var target_pos = Vector2()
var target_direction = Vector2()
var is_moving = false
var move_click = false
var type
var can_capture = true
var can_move = false
var grid
var current_pos = Vector2()
var new_pos = Vector2()
onready var Capture = preload("res://Capture.tscn")
onready var Capture_B = preload("res://Blue_Capture.tscn")
var on_right_click = false
var on_left_click = false
var is_down = false
var actions_left = 2
var text_visible = false
var is_selected = false
var tick


func _ready():
	grid = get_parent()
	type = grid.PLAYER
	$Glow.hide()
	$capture_roll.set_text("")
	grid.get_node("Action Counter Blue").set_text("Blue actions: " + str(actions_left))
	set_physics_process(true)


func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		current_pos = grid.world_to_map(event.position)
		$capture_roll.set_text("")
		print("Clicked " + str(self))
		is_selected = true
		return(self)
		
func _input(event):
	if event.is_action_pressed("right_click") and is_selected:
		grid.grid[0][0] = null
		new_pos = grid.world_to_map(event.position)
		self.movecheck()

#	if event.is_action_released("left_click") and move_click:
#		new_pos = grid.world_to_map(event.position)
#		print("Mouse Click to move at: ", new_pos)
#		$capture_roll.set_text("")
#		move_click = false
#		on_left_click = true


func _physics_process(delta):
	if is_selected:
		$Glow.show()
	else:
		$Glow.hide()
	tick = delta
	grid.get_node("Action Counter Blue").set_text("Blue actions: " + str(actions_left))
	if on_right_click:
		if get_parent().grid[current_pos.x][current_pos.y] == grid.PLAYER:
				print("This is a BLUE player.")
				on_right_click = false
		elif get_parent().grid[current_pos.x][current_pos.y] == grid.CAPTURE_N:
				print("This is a NEUTRAL castle.")
				on_right_click = false
		elif get_parent().grid[current_pos.x][current_pos.y] == grid.CAPTURE_B:
				print("This is a BLUE castle.")
				on_right_click = false
#	elif on_left_click:
#		on_left_click = false
#		var distancex = abs(new_pos.x - current_pos.x)
#		var distancey = abs(new_pos.y - current_pos.y)
#		print("Distance X: " +str(distancex))
#		print("Distance Y: " +str(distancey))
#		if is_down == false:
#			get_parent().get_node("Player2").actions_left = 2
#			if distancex == 2 and distancey == 0 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_B and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER2 and actions_left == 2:
#				can_move = true
#				actions_left = actions_left - 2
#			elif distancey == 2 and distancex == 0 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_B and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER2 and actions_left == 2:
#				can_move = true
#				actions_left = actions_left - 2
#			elif distancex == 1 and distancey == 1 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_B and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER2 and actions_left >= 1:
#				can_move = true
#				actions_left = actions_left - 1
#			elif distancex == 1 and distancey == 0 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_B and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER2 and actions_left >= 1:
#				can_move = true
#				actions_left = actions_left - 1
#			elif distancey == 1 and distancex == 0 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_B and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER2 and actions_left >= 1:
#				can_move = true
#				actions_left = actions_left - 1
#			elif distancex == 1 and distancey == 0 and get_parent().grid[new_pos.x][new_pos.y] == grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER2 and actions_left >= 1:
#				can_capture = true
#				actions_left = actions_left - 1
#			elif distancey == 1 and distancex == 0 and get_parent().grid[new_pos.x][new_pos.y] == grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER2 and actions_left >= 1:
#				can_capture = true
#				actions_left = actions_left - 1
#			elif distancex == 1 and distancey == 0 and get_parent().grid[new_pos.x][new_pos.y] == grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER2 and actions_left >= 1:
#				can_capture = true
#				actions_left = actions_left - 1
#			elif distancey == 1 and distancex == 0 and get_parent().grid[new_pos.x][new_pos.y] == grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER2 and actions_left >= 1:
#				can_capture = true
#				actions_left = actions_left - 1

	if can_move:
		print("Move!")
		var moveto = grid.map_to_world(new_pos)
		var movefrom = grid.map_to_world(current_pos)
		var vector = moveto - movefrom
		move_and_slide(vector * MAX_SPEED * delta)
		self.set_position(grid.update_child_pos(self))
		get_parent().grid[current_pos.x][current_pos.y] = null
		can_move = false
	on_left_click = false
	if can_capture:
		can_capture = false
		on_left_click = false
		randomize()
		if new_pos != Vector2(0, 0):
			if abs(new_pos.x - current_pos.x) == 1 and abs(new_pos.y - current_pos.y) == 0 or abs(new_pos.x - current_pos.x) == 0 and abs(new_pos.y - current_pos.y) == 1:
				if get_parent().grid[new_pos.x][new_pos.y] == grid.CAPTURE_N:
					$capture_roll.set_text("Success!")
					grid.bluecap()
				elif get_parent().grid[new_pos.x][new_pos.y] == grid.CAPTURE_R:
					var result = randf()
					print(result)
					print("total blue = " +str(float(grid.totalblue())/8))
					if result < float(grid.totalblue())/8:
						$capture_roll.set_text("Success!")
						grid.bluecap()
					else:
						$capture_roll.set_text("Failed!")
	grid.wincheck()
	#if grid.hasneutral == false:
		

func selection():
	if is_selected == true:
		new_pos = get_parent().get_parent().click_pos
		movecheck()
	elif is_selected == false:
		is_selected = true
		global.selected_piece_name = "even"
		current_pos = get_parent().get_parent().click_pos
	
func movecheck():
	if actions_left != 0:
		var distancex = abs(new_pos.x - current_pos.x)
		var distancey = abs(new_pos.y - current_pos.y)
		print("Distance X: " +str(distancex))
		print("Distance Y: " +str(distancey))
		print(str(actions_left))
		if distancex <= actions_left and distancey == 0 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_B and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER2:
			can_move = true
			actions_left = actions_left - distancex
		elif distancey <= actions_left and distancex == 0 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_B and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER2:
			can_move = true
			actions_left = actions_left - distancey
		elif distancex == 1 and distancey == 1 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_B and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER2 and actions_left >= 1:
			can_move = true
			actions_left = actions_left - 1
		elif distancex == 1 and distancey == 0 and get_parent().grid[new_pos.x][new_pos.y] == grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER2 and actions_left >= 1:
			can_capture = true
			actions_left = actions_left - 1
		elif distancey == 1 and distancex == 0 and get_parent().grid[new_pos.x][new_pos.y] == grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER2 and actions_left >= 1:
			can_capture = true
			actions_left = actions_left - 1
		elif distancex == 1 and distancey == 0 and get_parent().grid[new_pos.x][new_pos.y] == grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER2 and actions_left >= 1:
			can_capture = true
			actions_left = actions_left - 1
		elif distancey == 1 and distancex == 0 and get_parent().grid[new_pos.x][new_pos.y] == grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER2 and actions_left >= 1:
			can_capture = true
			actions_left = actions_left - 1
		if can_move:
			movement()
		if can_capture:
			capture()

func movement():
	is_selected = false
	print("Move!")
	var moveto = grid.map_to_world(new_pos)
	var movefrom = grid.map_to_world(current_pos)
	var vector = moveto - movefrom
	move_and_slide(vector * MAX_SPEED * tick)
	self.set_position(grid.update_child_pos(self))
	get_parent().grid[current_pos.x][current_pos.y] = null
	can_move = false

func capture():
	pass
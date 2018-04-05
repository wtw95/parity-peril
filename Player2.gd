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
var can_move = false
var can_capture = false
var grid 
var current_pos = Vector2()
var new_pos = Vector2()
onready var Capture = preload("res://Capture.tscn")
var on_right_click = false
var on_left_click = false
var is_down = false
var actions_left = 2
var is_selected = false


func _ready():
	grid = get_parent()
	type = grid.PLAYER2
	$Glow.hide()
	$capture_roll.set_text("")
	grid.get_node("Action Counter Red").set_text("Red actions: " + str(actions_left))
	set_physics_process(true)


func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		print("Clicked " + str(self))
		is_selected = true
		return(self)

#func _input(event):
#	if event.is_action_released("right_click"):
#		current_pos = grid.world_to_map(event.position)
#		print("Mouse Click to select at: ", current_pos)
#		$capture_roll.set_text("")
#		move_click = true
#		on_right_click = true

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
	grid.get_node("Action Counter Red").set_text("Red actions: " + str(actions_left))
	if on_right_click:
		if get_parent().grid[current_pos.x][current_pos.y] == grid.PLAYER2:
				print("This is a RED player.")
				on_right_click = false
		elif get_parent().grid[current_pos.x][current_pos.y] == grid.CAPTURE_N:
				print("This is a NEUTRAL castle.")
				on_right_click = false
	elif on_left_click:
		if current_pos != Vector2():
			var distancex = abs(new_pos.x - current_pos.x)
			var distancey = abs(new_pos.y - current_pos.y)
			if is_down == false:
				on_left_click = false
				get_parent().get_node("Player").actions_left_B= 2
				if distancex == 2 and distancey == 0 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_B and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER and actions_left == 2:
					can_move = true
					actions_left = actions_left - 2
				elif distancey == 2 and distancex == 0 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_B and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER and actions_left == 2:
					can_move = true
					actions_left = actions_left - 2
				elif distancex == 1 and distancey == 1 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_B and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER and actions_left >= 1:
					can_move = true
					actions_left = actions_left - 1
				elif distancex == 1 and distancey == 0 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_B and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER and actions_left >= 1:
					can_move = true
					actions_left = actions_left - 1
				elif distancey == 1 and distancex == 0 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_B and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER and actions_left >= 1:
					can_move = true
					actions_left = actions_left - 1
				elif distancex == 1 and distancey == 0 and get_parent().grid[new_pos.x][new_pos.y] == grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER and actions_left >= 1:
					can_capture = true
					actions_left = actions_left - 1
				elif distancey == 1 and distancex == 0 and get_parent().grid[new_pos.x][new_pos.y] == grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER and actions_left >= 1:
					can_capture = true
					actions_left = actions_left - 1
				elif distancex == 1 and distancey == 0 and get_parent().grid[new_pos.x][new_pos.y] == grid.CAPTURE_B and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER and actions_left >= 1:
					can_capture = true
					actions_left = actions_left - 1
				elif distancey == 1 and distancex == 0 and get_parent().grid[new_pos.x][new_pos.y] == grid.CAPTURE_B and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER and actions_left >= 1:
					can_capture = true
					actions_left = actions_left - 1
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
						grid.redcap()
					elif get_parent().grid[new_pos.x][new_pos.y] == grid.CAPTURE_B:
						var result = randf()
						print(result)
						print("total red = " +str(float(grid.totalred())/8))
						if result < float(grid.totalred())/8:
							$capture_roll.set_text("Success!")
							grid.redcap()
						else:
							$capture_roll.set_text("Failed!")
func selection():
	if is_selected == false:
		is_selected = true
		current_pos = get_parent().get_parent().click_pos
	elif is_selected == true:
		new_pos = get_parent().get_parent().click_pos
		movecheck()
		

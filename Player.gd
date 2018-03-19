extends KinematicBody2D

var direction = Vector2()

const MAX_SPEED = 4000

var speed = 0
var velocity = Vector2()

var target_pos_B = Vector2()
var target_direction_B = Vector2()
var is_moving_B = false
var move_click_B = false
var type
var can_capture_B = true
var can_move_B = false
var grid
var current_pos_B = Vector2()
var new_pos_B = Vector2()
onready var Capture = preload("res://Capture.tscn")
onready var Capture_B = preload("res://Blue_Capture.tscn")
var on_right_click_B = false
var on_left_click_B = false
var is_down = false
var actions_left_B = 2
var text_visible = false


func _ready():
	grid = get_parent()
	type = grid.PLAYER
	$capture_roll.clear()
	set_physics_process(true)

func _input(event):
	if event.is_action_released("right_click"):
		current_pos_B = grid.world_to_map(event.position)
		print("Mouse Click to select at: ", current_pos_B)
		$capture_roll.clear()
		grid.grid[0][0] = null
		move_click_B = true
		on_right_click_B = true

	if event.is_action_released("left_click") and move_click_B:
		new_pos_B = grid.world_to_map(event.position)
		print("Mouse Click to move at: ", new_pos_B)
		$capture_roll.clear()
		move_click_B = false
		on_left_click_B = true


func _physics_process(delta):
	if on_right_click_B:
		if get_parent().grid[current_pos_B.x][current_pos_B.y] == grid.PLAYER:
				print("This is a BLUE player.")
				on_right_click_B = false
		elif get_parent().grid[current_pos_B.x][current_pos_B.y] == grid.CAPTURE_N:
				print("This is a NEUTRAL castle.")
				on_right_click_B = false
		elif get_parent().grid[current_pos_B.x][current_pos_B.y] == grid.CAPTURE_B:
				print("This is a BLUE castle.")
				on_right_click_B = false
	elif on_left_click_B:
		var distancex = abs(new_pos_B.x - current_pos_B.x)
		var distancey = abs(new_pos_B.y - current_pos_B.y)
		if is_down == false:
			get_parent().get_node("Player2").actions_left = 2
			if distancex == 2 and distancey == 0 and get_parent().grid[new_pos_B.x][new_pos_B.y] != grid.CAPTURE_N and get_parent().grid[new_pos_B.x][new_pos_B.y] != grid.PLAYER2 and actions_left_B == 2:
				can_move_B = true
				actions_left_B = actions_left_B - 2
			elif distancey == 2 and distancex == 0 and get_parent().grid[new_pos_B.x][new_pos_B.y] != grid.CAPTURE_N and get_parent().grid[new_pos_B.x][new_pos_B.y] != grid.PLAYER2 and actions_left_B == 2:
				can_move_B = true
				actions_left_B = actions_left_B - 2
			elif distancex == 1 and distancey == 1 and get_parent().grid[new_pos_B.x][new_pos_B.y] != grid.CAPTURE_N and get_parent().grid[new_pos_B.x][new_pos_B.y] != grid.PLAYER2 and actions_left_B == 2:
				can_move_B = true
				actions_left_B = actions_left_B - 1
			elif distancex == 1 and distancey == 0 and get_parent().grid[new_pos_B.x][new_pos_B.y] != grid.CAPTURE_N and get_parent().grid[new_pos_B.x][new_pos_B.y] != grid.PLAYER2 and actions_left_B >= 1:
				can_move_B = true
				actions_left_B = actions_left_B - 1
			elif distancey == 1 and distancex == 0 and get_parent().grid[new_pos_B.x][new_pos_B.y] != grid.CAPTURE_N and get_parent().grid[new_pos_B.x][new_pos_B.y] != grid.PLAYER2 and actions_left_B >= 1:
				can_move_B = true
				actions_left_B = actions_left_B - 1
			elif distancex == 1 and distancey == 0 and get_parent().grid[new_pos_B.x][new_pos_B.y] == grid.CAPTURE_N and get_parent().grid[new_pos_B.x][new_pos_B.y] != grid.PLAYER2 and actions_left_B >= 1:
				can_capture_B = true
			elif distancey == 1 and distancex == 0 and get_parent().grid[new_pos_B.x][new_pos_B.y] == grid.CAPTURE_N and get_parent().grid[new_pos_B.x][new_pos_B.y] != grid.PLAYER2 and actions_left_B >= 1:
				can_capture_B = true
			elif current_pos_B == Vector2(0,0):
					print("OH GOD HELP ME")
	if can_move_B:
		print("Move!")
		var moveto = grid.map_to_world(new_pos_B)
		var movefrom = grid.map_to_world(current_pos_B)
		var vector = moveto - movefrom
		move_and_slide(vector * MAX_SPEED * delta)
		self.set_position(grid.update_child_pos(self))
		get_parent().grid[current_pos_B.x][current_pos_B.y] = null
		can_move_B = false
		on_left_click_B = false
	if can_capture_B:
		can_capture_B = false
		on_left_click_B = false
		randomize()
		var result = randi() % 2
		print(result)
		if result == 0:
			actions_left_B = actions_left_B - 1
			$capture_roll.set_text("No capture!")
		else:
			$capture_roll.set_text("Captured!")
			grid.bluecap()
		#	get_parent().grid[new_pos_B.x][new_pos_B.y] = get_parent().get_node("Blue_Capture")
			actions_left_B = actions_left_B - 1
			
			#get_parent().get_node("Capture Point").bluecapture()
			#get_parent().grid[new_pos_B.x][new_pos_B.y] = grid.CAPTURE_B
		
#	if Input.is_action_pressed("move_up"):
#		direction.y = -1
#	elif Input.is_action_pressed("move_down"):
#		direction.y = 1
#
#	if Input.is_action_pressed("move_left"):
#		direction.x = -1
#	elif Input.is_action_pressed("move_right"):
#		direction.x = 1
#
#	if not is_moving and direction != Vector2():
#		target_direction = direction.normalized()
#		if grid.is_cell_vacant(get_position(), direction):
#			target_pos = grid.update_child_pos(get_position(), direction, type)
#			is_moving = true
#	elif is_moving:
#		speed = MAX_SPEED
#		velocity = speed * target_direction * delta

#		var pos = get_position()
#		var distance_to_target = pos.distance_to(target_pos)
#		var move_distance = velocity.length()
#
#		if move_distance > distance_to_target:
#				velocity = target_direction * distance_to_target
#			is_moving = false

#		move(speed * target_direction)

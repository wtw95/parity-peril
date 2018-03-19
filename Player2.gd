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


func _ready():
	grid = get_parent()
	type = grid.PLAYER2
	set_physics_process(true)

func _input(event):
	if event.is_action_released("right_click"):
		current_pos = grid.world_to_map(event.position)
		print("Mouse Click to select at: ", current_pos)
		$capture_roll.clear()
		move_click = true
		on_right_click = true

	if event.is_action_released("left_click") and move_click:
		new_pos = grid.world_to_map(event.position)
		print("Mouse Click to move at: ", new_pos)
		$capture_roll.clear()
		move_click = false
		on_left_click = true


func _physics_process(delta):
	direction = Vector2()
	speed = 0

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
				get_parent().get_node("Player").actions_left_B= 2
				if distancex == 2 and distancey == 0 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER and actions_left == 2:
					can_move = true
					actions_left = actions_left - 2
				elif distancey == 2 and distancex == 0 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER and actions_left == 2:
					can_move = true
					actions_left = actions_left - 2
				elif distancex == 1 and distancey == 1 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER and actions_left == 2:
					can_move = true
					actions_left = actions_left - 1
				elif distancex == 1 and distancey == 0 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER and actions_left >= 1:
					can_move = true
					actions_left = actions_left - 1
				elif distancey == 1 and distancex == 0 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER and actions_left >= 1:
					can_move = true
					actions_left = actions_left - 1
				elif distancex == 1 and distancey == 0 and get_parent().grid[new_pos.x][new_pos.y] == grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER and actions_left >= 1:
					can_capture = true
				elif distancey == 1 and distancex == 0 and get_parent().grid[new_pos.x][new_pos.y] == grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER and actions_left >= 1:
					can_capture = true
				elif current_pos == Vector2(0,0):
						print("OH GOD HELP ME")
		if can_move:
			print("Move!")
			var moveto = grid.map_to_world(new_pos)
			var movefrom = grid.map_to_world(current_pos)
			var vector = moveto - movefrom
			#while moveto != movefrom:
			#move_and_slide(Vector2(current_pos.x - new_pos.x, current_pos.y - new_pos.y) * MAX_SPEED * delta)
			move_and_slide(vector * MAX_SPEED * delta)
			self.set_position(grid.update_child_pos(self))
			get_parent().grid[current_pos.x][current_pos.y] = null
			can_move = false
		on_left_click = false
		if can_capture:
			can_capture = false
			on_left_click = false
			randomize()
			var result = randi() % 2
			print(result)
			if result == 0:
				actions_left = actions_left - 1
				$capture_roll.set_text("No capture!")
			else:
				$capture_roll.set_text("Captured!")
				actions_left = actions_left - 1
				get_parent().get_node("Capture Point").get_node("Sprite").texture = load("res://assets/Sprites/HoldingR.png")
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

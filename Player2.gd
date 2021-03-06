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
var tick
var can_fight = false
var frame_offset = 0
var is_dead = false
var is_alone = false

func _ready():
	grid = get_parent()
	type = grid.PLAYER2
	$Glow.hide()
	$capture_roll.set_text("")
	set_physics_process(true)


func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		print("Clicked " + str(self))
		is_selected = true
		return(self)

func _input(event):
	if event.is_action_pressed("right_click") and is_selected:
		grid.grid[0][0] = null
		new_pos = grid.world_to_map(event.position)
		self.movecheck()



func _physics_process(delta):
	tick = delta
	if global.even_deaths == 2:
		is_alone = true
	if is_selected and global.current_player == "even":
		$Glow.show()
	else:
		$Glow.hide()
	if is_down:
		frame_offset = 4
	else:
		frame_offset = 0

func selection():
	if is_selected == false:
		is_selected = true
		current_pos = get_parent().get_parent().click_pos

func movecheck():
	if global.current_player == "even":
		if is_down:
			actions_left = actions_left - 1
		if actions_left > 0:
			var distancex = abs(new_pos.x - current_pos.x)
			var distancey = abs(new_pos.y - current_pos.y)
			print("Distance X: " +str(distancex))
			print("Distance Y: " +str(distancey))
			print(str(actions_left))
			if distancex <= actions_left and distancey == 0 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_B and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER:
				can_move = true
				actions_left = actions_left - distancex
			elif distancey <= actions_left and distancex == 0 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_B and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER:
				can_move = true
				actions_left = actions_left - distancey
			elif distancex == 1 and distancey == 1 and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_N and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_B and get_parent().grid[new_pos.x][new_pos.y] != grid.CAPTURE_R and get_parent().grid[new_pos.x][new_pos.y] != grid.PLAYER and actions_left >= 1:
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
			elif distancex == 1 and distancey == 0 and get_parent().grid[new_pos.x][new_pos.y] == grid.PLAYER:
				can_fight = true
				actions_left = actions_left - 1
			elif distancey == 1 and distancex == 0 and get_parent().grid[new_pos.x][new_pos.y] == grid.PLAYER:
				can_fight = true
				actions_left = actions_left - 1
			if can_move:
				movement()
			if can_capture:
				capture()
			if can_fight:
				fight()

func movement():
	is_selected = false
	print("Move!")
	var moveto = grid.map_to_world(new_pos)
	var movefrom = grid.map_to_world(current_pos)
	var vector = moveto - movefrom
	if moveto.x == movefrom.x and moveto.y > movefrom.y or abs(moveto.x - movefrom.x) == 150 and moveto.y > movefrom.y:
		if is_alone:
			get_parent().get_node("AudioHandler/Brothers").play()
		else:
			get_parent().get_node("AudioHandler/South").play()
		get_node("Sprite").frame = 0 + frame_offset
	elif moveto.x == movefrom.x and moveto.y < movefrom.y or abs(moveto.x - movefrom.x) == 150 and moveto.y < movefrom.y:
		if is_alone:
			get_parent().get_node("AudioHandler/Brothers").play()
		elif is_down:
			get_parent().get_node("AudioHandler/FallBack1").play()
		else:
			get_parent().get_node("AudioHandler/North").play()
		get_node("Sprite").frame = 10 + frame_offset
	elif moveto.y == movefrom.y and moveto.x > movefrom.x:
		if is_alone:
			get_parent().get_node("AudioHandler/Brothers").play()
		else:
			get_parent().get_node("AudioHandler/East").play()
		get_node("Sprite").flip_h = false
		get_node("Sprite").frame = 5 + frame_offset
	elif moveto.y == movefrom.y and moveto.x < movefrom.x:
		if is_alone:
			get_parent().get_node("AudioHandler/Brothers").play()
		else:
			get_parent().get_node("AudioHandler/West").play()
		get_node("Sprite").frame = 5 + frame_offset
		get_node("Sprite").flip_h = true
	move_and_slide(vector * MAX_SPEED * tick)
	self.set_position(grid.update_child_pos(self))
	get_parent().grid[current_pos.x][current_pos.y] = null
	can_move = false
	

func capture():
	can_capture = false
	if new_pos.x > current_pos.x and not is_down:
		get_node("Sprite").flip_h = false
		get_node("Sprite").frame = 8
	elif new_pos.x < current_pos.x and not is_down:
		get_node("Sprite").flip_h = true
		get_node("Sprite").frame = 8
	elif new_pos.y > current_pos.y and not is_down:
		get_node("Sprite").frame = 1
	elif new_pos.y < current_pos.y and not is_down:
		get_node("Sprite").frame = 11
	randomize()
	if new_pos != Vector2(0, 0):
		if abs(new_pos.x - current_pos.x) == 1 and abs(new_pos.y - current_pos.y) == 0 or abs(new_pos.x - current_pos.x) == 0 and abs(new_pos.y - current_pos.y) == 1:
			if get_parent().grid[new_pos.x][new_pos.y] == grid.CAPTURE_N:
				$capture_roll.set_text("Success!")
				if new_pos.y - current_pos.y == -1 and not is_down:
					get_parent().get_node("AudioHandler/Front").play()
				elif not is_down:
					get_parent().get_node("AudioHandler/TakeCastle").play()
				else:
					get_parent().get_node("AudioHandler/Return").play()
				if is_down:
					get_node("Sprite").frame = get_node("Sprite").frame - frame_offset
					is_down = false
				grid.redcap(new_pos)
			elif get_parent().grid[new_pos.x][new_pos.y] == grid.CAPTURE_B:
				var result = randf()
				print(result)
				print("total red = " +str(float(grid.totalred())/8))
				if result < float(grid.totalred())/8:
					if is_down:
						get_node("Sprite").frame = get_node("Sprite").frame - frame_offset
						get_parent().get_node("AudioHandler/Return").play()
						is_down = false
					else:
						get_parent().get_node("AudioHandler/TakeCastle").play()
					$capture_roll.set_text("Success!")
					grid.redcap(new_pos)
				else:
					$capture_roll.set_text("Failed!")


func fight():
	can_fight = false
	get_parent().get_node("AudioHandler/Attack").play()
	if new_pos.x > current_pos.x and not is_down:
		get_node("Sprite").flip_h = false
		get_node("Sprite").frame = 8
	elif new_pos.x < current_pos.x and not is_down:
		get_node("Sprite").flip_h = true
		get_node("Sprite").frame = 8
	elif new_pos.y > current_pos.y and not is_down:
		get_node("Sprite").frame = 2
	elif new_pos.y < current_pos.y and not is_down:
		get_node("Sprite").frame = 12
	randomize()
	var result = randf()
	if result < .5:
		$capture_roll.set_text("Success!")
		hit(new_pos)
	else:
		$capture_roll.set_text("Failed!")


func hit(pos):
	if grid.world_to_map(get_parent().get_node("Odd_A").get_position()) == pos:
		if get_parent().get_node("Odd_A").is_down == true:
			var deathsound = randf()
			if deathsound < .25:
				get_parent().get_node("AudioHandler/StrangeDeath").play()
			elif deathsound > .25 and deathsound < .5:
				get_parent().get_node("AudioHandler/LaughingDeath").play()
			elif deathsound > .5 and deathsound < .75:
				get_parent().get_node("AudioHandler/Death1").play()
			else:
				get_parent().get_node("AudioHandler/Death2").play()
			get_parent().get_node("Odd_A/Sprite").hide()
			get_parent().get_node("Odd_A").set_position(Vector2(1500,1500))
			get_parent().get_node("Odd_A").is_dead = true
			global.odd_deaths = global.odd_deaths + 1
			grid.grid[pos.x][pos.y] = null
		else:
			get_parent().get_node("Odd_A").is_down = true
			get_parent().get_node("Odd_A/Sprite").frame = get_parent().get_node("Odd_A/Sprite").frame + 4
			get_parent().get_node("AudioHandler/Hurt").play()
	elif grid.world_to_map(get_parent().get_node("Odd_B").get_position()) == pos:
		if get_parent().get_node("Odd_B").is_down == true:
			var deathsound = randf()
			if deathsound < .25:
				get_parent().get_node("AudioHandler/StrangeDeath").play()
			elif deathsound > .25 and deathsound < .5:
				get_parent().get_node("AudioHandler/LaughingDeath").play()
			elif deathsound > .5 and deathsound < .75:
				get_parent().get_node("AudioHandler/Death1").play()
			else:
				get_parent().get_node("AudioHandler/Death2").play()
			get_parent().get_node("Odd_B/Sprite").hide()
			get_parent().get_node("Odd_B").set_position(Vector2(1500,1500))
			get_parent().get_node("Odd_B").is_dead = true
			global.odd_deaths = global.odd_deaths + 1
			grid.grid[pos.x][pos.y] = null
		else:
			get_parent().get_node("Odd_B").is_down = true
			get_parent().get_node("Odd_B/Sprite").frame = get_parent().get_node("Odd_B/Sprite").frame + 4
			get_parent().get_node("AudioHandler/Hurt").play()
	elif grid.world_to_map(get_parent().get_node("Odd_C").get_position()) == pos:
		if get_parent().get_node("Odd_C").is_down == true:
			var deathsound = randf()
			if deathsound < .25:
				get_parent().get_node("AudioHandler/StrangeDeath").play()
			elif deathsound > .25 and deathsound < .5:
				get_parent().get_node("AudioHandler/LaughingDeath").play()
			elif deathsound > .5 and deathsound < .75:
				get_parent().get_node("AudioHandler/Death1").play()
			else:
				get_parent().get_node("AudioHandler/Death2").play()
			get_parent().get_node("Odd_C/Sprite").hide()
			get_parent().get_node("Odd_C").set_position(Vector2(1500,1500))
			get_parent().get_node("Odd_C").is_dead = true
			global.odd_deaths = global.odd_deaths + 1
			grid.grid[pos.x][pos.y] = null
		else:
			get_parent().get_node("Odd_C").is_down = true
			get_parent().get_node("Odd_C/Sprite").frame = get_parent().get_node("Odd_C/Sprite").frame + 4
			get_parent().get_node("AudioHandler/Hurt").play()

func refill_actions():
	actions_left = 2
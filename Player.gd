extends KinematicBody2D

var direction = Vector2()

const UP = Vector2(0,-1)
const DOWN = Vector2(0,1)
const RIGHT = Vector2(1,0)
const LEFT = Vector2(-1,0)
var speed = 0
const MAX_SPEED = 400

func _ready():
	set_physics_process(true)
	
	

func _physics_process(delta):
	var is_moving = Input.is_action_pressed("movement_check")
	
	if is_moving:
		speed = MAX_SPEED
	
		if Input.is_action_pressed("ui_up"):
			direction = UP
		elif Input.is_action_pressed("ui_down"):
			direction = DOWN
		elif Input.is_action_pressed("ui_left"):
			direction = LEFT
		elif Input.is_action_pressed("ui_right"):
			direction = RIGHT
	else:
		speed = 0
		
	move_and_slide(speed * direction)
	pass
	

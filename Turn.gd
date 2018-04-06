extends Area2D


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		print("Clicked " + str(self))
		if global.current_player == "even":
			get_node("Sprite").frame = 0
			global.current_player = "odd"
			get_parent().get_node("Odd_A").refill_actions()
			get_parent().get_node("Odd_B").refill_actions()
			get_parent().get_node("Odd_C").refill_actions()
		else:
			get_node("Sprite").frame = 1
			global.current_player = "even"
			get_parent().get_node("Even_A").refill_actions()
			get_parent().get_node("Even_B").refill_actions()
			get_parent().get_node("Even_C").refill_actions()
		return(self)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
extends Area2D


func _ready():
	pass

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		print("Clicked " + str(self))
		get_parent().set_position(Vector2(2000,2000))

extends Area2D



func _ready():
	pass

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		print("Clicked " + str(get_parent()))
		get_parent().current_pos = get_parent().get_parent().world_to_map(event.position)
		get_parent().is_selected = true
		return(get_parent())

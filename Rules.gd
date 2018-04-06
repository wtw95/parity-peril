extends Area2D


var rulesframe = 0

func _ready():
	pass

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		print("Clicked " + str(self))
		get_parent().get_node("Title").hide()
		get_parent().get_node("Play").hide()
		get_parent().get_node("Ruleset").show()
		self.hide()

func _input(event):
	if event.is_action_pressed("ui_select"):
		if rulesframe <= 5:
			get_parent().get_node("Ruleset").frame = get_parent().get_node("Ruleset").frame + 1
			rulesframe = rulesframe + 1
		if rulesframe == 6:
			get_parent().get_node("Title").show()
			get_parent().get_node("Play").show()
			get_parent().get_node("Ruleset").hide()
			self.show()
			get_parent().get_node("Ruleset").frame = 0
			rulesframe = 0
		
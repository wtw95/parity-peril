extends Node

var selected_piece_name = "None"
var selected_piece_pos = Vector2(-1, -1)
var selected_piece = "None"

var current_player = "even"


var state = []


func _ready():
	# Dash for empty square
	# w for white piece
	# b for black piece
	for i in range(8):
		state.append([])
		for j in range(6):
			state[i].append("-")
extends Sprite


var red = preload("res://assets/Sprites/HoldingR.png")
var blue = preload("res://assets/Sprites/HoldingB.png")
func _ready():
	pass
	
func set_color(color):
	if color == "blue":
		self.set_texture(blue)
		print("Blue capture!")
	else:
		self.set_texture(red)

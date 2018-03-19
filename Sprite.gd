extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var red = preload("res://assets/Sprites/HoldingR.png")
var blue = preload("res://assets/Sprites/HoldingB.png")
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
func set_color(color):
	if color == "blue":
		self.set_texture(blue)
		print("Blue capture!")
	else:
		self.set_texture(red)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

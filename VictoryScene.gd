extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func bluevictory():
	get_node("Blue Victory").show()
	get_parent().get_node("AudioHandler/ForOdddom").play()
	
func redvictory():
	get_node("Red Victory").show()
	get_parent().get_node("AudioHandler/ForEvenhood").play()
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

extends Control



func _ready():
	pass

func bluevictory():
	get_node("Blue Victory").show()
	get_parent().get_node("AudioHandler/ForOdddom").play()
	
func redvictory():
	get_node("Red Victory").show()
	get_parent().get_node("AudioHandler/ForEvenhood").play()

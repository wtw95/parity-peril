extends Node

var arrayBlue = Array()
var arrayRed = Array()

func _ready():
    print("Global ready!")

func arrayBlue_add(addName):
    arrayBlue.push_back(addName)

func arrayBlue_size():
    return arrayBlue.size()

func arrayRed_add(addName):
    arrayRed.push_back(addName)

func arrayRed_size():
    return arrayRed.size()
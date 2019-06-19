extends Node2D

var waveCurrent = 0

var spawnerList = []


var HP = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func addSpawner(spawnerToAdd):
	spawnerList.append(spawnerToAdd)

func damange():
	print("oyuch")
	HP -= 1
	if (waveCurrent == 0):

		waveCurrent = 1
	if (HP<0):
		print("beacon down")


func _on_DetectionRange_body_entered(body):
	damange()
	body.pop()
	pass # Replace with function body.

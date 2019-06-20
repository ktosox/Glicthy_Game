extends Node


var playerHP = 3

var playerCurrent 

var enemyCount
var enemyCountMax = 50

var listAllGates = {0:null}


var mainMenuPath = "" #once added, main menu path should go here

var firstLevelPath = "" # once added, first level path should go here

var pauseMenuScene = load("res://GameParts/PauseMenu/PauseMenu.tscn")

var ganeOverMenuScene = load("res://GameParts/GameOverMenu/GameOverMenu.tscn")

func _ready():

	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func changeToMainMenu():
	get_tree().change_scene(mainMenuPath)

func changeToFirstLevel():
	get_tree().change_scene(firstLevelPath)

func pause_game():
	var newPauseMenu = pauseMenuScene.instance()
	playerCurrent.add_child(newPauseMenu)
	get_tree().paused = true

func lose_game():
	var newGameOverMenu = ganeOverMenuScene.instance()
	playerCurrent.add_child(newGameOverMenu)
	get_tree().paused = true


func win_game():
	pass

# gate stuff

func addGate(gateNumber, gateNode):
	if(listAllGates.has(gateNumber)):
		print("there can only be one gate: ",gateNumber," -this message was sponsored by: ", gateNode)
	else:
		listAllGates[gateNumber] = gateNode

func openGate(gateNumber):
	listAllGates[gateNumber].openGate()


extends Node


var playerHP = 3

var firstGo = true

var playerCurrent 
var currentLevel = 1

var BS = 7.6

var enemyCount

var listAllGates = {0:null}


var mainMenuPath = "" #once added, main menu path should go here

var aboutPath = "res://GameParts/About.tscn"

var firstLevelPath = "res://Levels/FirstLevel.tscn"

var secondLeveLPath = "res://Levels/SecondLevel.tscn"

var pauseMenuScene = load("res://GameParts/PauseMenu/PauseMenu.tscn")

var gameOverMenuScene = load("res://GameParts/GameOverMenu/GameOverMenu.tscn")

func _ready():

	pass


#func _process(delta):
#	pass

func changeToMainMenu():
	get_tree().change_scene(mainMenuPath)

func changeToFirstLevel():
	GM.listAllGates.clear()
	currentLevel=1
	get_tree().change_scene(firstLevelPath)

func changeToSecondLevel():
	GM.listAllGates.clear()
	currentLevel=2
	get_tree().change_scene(secondLeveLPath)

func pause_game():
	var newPauseMenu = pauseMenuScene.instance()
	playerCurrent.add_child(newPauseMenu)
	get_tree().paused = true

func lose_game():
	var newGameOverMenu = gameOverMenuScene.instance()
	playerCurrent.add_child(newGameOverMenu)
	get_tree().paused = true


func win_game():
	if(currentLevel==1):
		currentLevel=2
		changeToSecondLevel()
	else:
		get_tree().change_scene(aboutPath)
	pass

# gate stuff

func addGate(gateNumber, gateNode):
	if(listAllGates.has(gateNumber)):
		print("there can only be one gate: ",gateNumber," -this message was sponsored by: ", gateNode)
	else:
		listAllGates[gateNumber] = gateNode

func openGate(gateNumber):
	if(gateNumber !=0):
		listAllGates[gateNumber].openGate()
	else:
		print("you cant open gate 0 silly")


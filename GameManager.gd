extends Node


var playerHP

var playerCurrent 

var enemyCount
var enemyCountMax

var mainMenuPath = ""

var firstLevelPath = ""

var pauseMenuScene = load("res://GameParts/PauseMenu/PauseMenu.tscn")

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
	pass


func win_game():
	pass

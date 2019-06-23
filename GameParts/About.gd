extends TextureRect

# Declare member variables here. Examples:

# var a = 2
# var b = "text"

var gameOverMenuScene = load("res://GameParts/GameOverMenu/GameOverMenu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		var newGameOverMenu = gameOverMenuScene.instance()
		add_child(newGameOverMenu)
		get_tree().paused = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

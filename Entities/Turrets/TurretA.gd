extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var GateNumber = 0

var enemyMode = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func scanForPlayer():
	if($DetectionRange.get_overlapping_bodies() != []):
		print("player spotted")
		enemyMode = 1
	else:
		enemyMode = 0
	pass

func _on_TimerCheckForPlayer_timeout():
	scanForPlayer()
	pass # Replace with function body.


func fireBullet():
	pass


func _on_TimerCooldown_timeout():
	pass # Replace with function body.

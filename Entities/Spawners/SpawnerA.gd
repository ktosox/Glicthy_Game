extends Node2D

var EnemyAScene = load("res://Entities/Enemies/EnemyA.tscn")


func _ready():
	pass


#func _process(delta):
#	pass

func spawnEnemyA():
	var newEnemyA = EnemyAScene.instance()
	newEnemyA.global_position = self.global_position
	get_parent().add_child(newEnemyA)

func startSpawning():
	$TimerAutoSpawn.start()
	pass

func stopSpawning():
	$TimerAutoSpawn.stop()
	pass

func _on_TimerAutoSpawn_timeout():
	spawnEnemyA()
	pass

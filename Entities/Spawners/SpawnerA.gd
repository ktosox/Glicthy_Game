extends Node2D

var EnemyBScene = load("res://Entities/Enemies/EnemyB.tscn")


func _ready():
	startSpawning()
	pass


#func _process(delta):
#	pass

func spawnEnemyB():
	var newEnemyB = EnemyBScene.instance()
	newEnemyB.global_position = self.global_position
	get_parent().add_child(newEnemyB)

func startSpawning():
	print("spawning started")
	$TimerAutoSpawn.start()
	pass

func stopSpawning():
	$TimerAutoSpawn.stop()
	pass

func _on_TimerAutoSpawn_timeout():
	spawnEnemyB()
	pass

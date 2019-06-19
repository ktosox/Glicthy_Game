extends KinematicBody2D

const MOTION_SPEED = 8

var direction = Vector2()
var motion = Vector2()
var moving = false

var bulletAScene = load("res://Entities/Bullets/BulletA.tscn")

var enemyMode = 0 # 0 for passive / 1 for active
var target = Vector2()


func _ready():
	startWalking()


func _physics_process(delta):
	if(moving):
		motion = direction.normalized() * MOTION_SPEED
		move_and_collide(motion)

func startWalking():
	#print(GM.playerCurrent)
	#print($DetectionRange.get_overlapping_bodies())
	scanForPlayer()
	if(enemyMode == 0):
		direction = Vector2((randf()*2)-1,(randf()*2)-1) #pick a direction
	elif(enemyMode == 1):
		direction = GM.playerCurrent.global_position-self.global_position

		#direction = Vector2(,) #pick a direction
	moving = true
	$TimerMoving.start()

func stopWalking():
	moving = false
	if (enemyMode == 1):
		var newBullet = bulletAScene.instance()
		newBullet.global_position = self.global_position
		get_parent().add_child(newBullet)
	$TimerStanding.start()

func startDying():
	$TimerDying.start()
	#add any death animation here

func scanForPlayer():
	if($DetectionRange.get_overlapping_bodies() != []):
		enemyMode = 1
	pass


func _on_TimerMoving_timeout():
	stopWalking()


func _on_TimerStanding_timeout():
	startWalking()


func _on_TimerDying_timeout():
	self.queue_free()
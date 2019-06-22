extends RigidBody2D

var HP = 3

const MOTION_SPEED = 8000

var direction = Vector2()

var moving = false

var bulletAScene = load("res://Entities/Bullets/BulletA.tscn")

var enemyMode = 0 # 0 for passive / 1 for active
var target = Vector2()


func _ready():
	startWalking()


func _physics_process(delta):
	if(moving):
		linear_velocity = direction.normalized() * MOTION_SPEED * delta

func startWalking():
	if(enemyMode == 0):
		direction = Vector2((randf()*2)-1,(randf()*2)-1) #pick a direction
		scanForPlayer()
	elif(enemyMode == 1):
		direction = GM.playerCurrent.global_position-self.global_position
		setTarget()
		#direction = Vector2(,) #pick a direction
	moving = true
	$TimerMoving.start()

func stopWalking():
	moving = false
	linear_velocity = Vector2(0,0)
	if (enemyMode == 1):
		canonStart()
	else:
		$TimerStanding.start()

func startDying():
	$HitBox.queue_free()
	$TimerDying.start()
	$Sprite.modulate.a = 0.2
	$ExplosionC.emitting = true

func scanForPlayer():
	if($DetectionRange.get_overlapping_bodies() != []):
		enemyMode = 1
		setTarget()
	else:
		enemyMode = 0
	pass

func damange():
	HP -= 1
	if(HP<1):
		startDying()

func canonFire():
	var newBullet = bulletAScene.instance()
	newBullet.global_position = $Sprite/CanonLeft/Octagon/Sprite.global_position
	newBullet.linear_velocity= target * GM.BS
	get_parent().add_child(newBullet)
	newBullet = bulletAScene.instance()
	newBullet.global_position = $Sprite/CanonRight/Octagon/Sprite.global_position
	newBullet.linear_velocity= target * GM.BS
	get_parent().add_child(newBullet)


func setTarget():
	target = GM.playerCurrent.global_position - global_position
	target=Vector2( clamp(target.x, -GM.BS*10,GM.BS*10),clamp(target.y, -GM.BS*10,GM.BS*10))
		

func canonStart():
	$AnimationPlayer.play("canon_extend")
	pass


func _on_TimerMoving_timeout():
	stopWalking()


func _on_TimerStanding_timeout():
	startWalking()


func _on_TimerDying_timeout():
	self.queue_free()

func pop():
	print("EnemyB pop")
	#self.queue_free()

func _on_HitBox_body_entered(body):
	if(body.get_collision_layer_bit(0)):
		damange()
		body.pop()

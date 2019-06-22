extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var HP = 2

const MOTION_SPEED = 5000

var direction = Vector2()

var moving = false

var bulletAScene = load("res://Entities/Bullets/BulletA.tscn")

var enemyMode = 0 # 0 for passive / 1 for active

var target


func _ready():
	wahtNow()
	pass

func wahtNow():
	scanForPlayer()
	match(randi()%3):
		0:
			startWalking()
		1:
			$AnimationPlayer.play("rotate")
		2:
			if(enemyMode == 1):
				$AnimationPlayer.play("open_fire")
			else:
				$TimerSleep.start()


func startWalking():
	if(enemyMode == 0):
		direction = Vector2(((randi()%2)*2)-1,((randi()%2)*2)-1) #pick a direction
	else:
		direction = GM.playerCurrent.global_position-self.global_position
		setTarget()
		#direction = Vector2(,) #pick a direction
	moving = true

func scanForPlayer():
	if($DetectionRange.get_overlapping_bodies() != []):
		enemyMode = 1
		setTarget()
	else:
		enemyMode = 0
	pass

func _physics_process(delta):
	if(moving):
		linear_velocity = direction.normalized() * MOTION_SPEED * delta

func startDying():
	$HitBox.queue_free()
	$TimerDying.start()
	$Sprite2.visible = false
	$ExplosionC.emitting = true


func canonFire():
	var newBullet = bulletAScene.instance()
	newBullet.global_position = global_position + Vector2(((randi()%2)*40)-20,((randi()%2)*40)-20)
	newBullet.linear_velocity= target * GM.BS
	get_parent().add_child(newBullet)

func damange():
	HP -= 1
	if(HP<1):
		startDying()


func pop():
	print("EnemyA Pop")
	#self.queue_free()

func _on_HitBox_body_entered(body):
	if(body.get_collision_layer_bit(0)):
		damange()
		body.pop()

func setTarget():
	target = GM.playerCurrent.global_position - global_position
	target=Vector2( clamp(target.x, -GM.BS*10,GM.BS*10),clamp(target.y, -GM.BS*10,GM.BS*10))

func _on_TimerDying_timeout():
	queue_free()

func _on_TimerSleep_timeout():
	wahtNow()

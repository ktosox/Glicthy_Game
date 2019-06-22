extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var HP = 2

const MOTION_SPEED = 5000

var direction = Vector2()

var moving = false

var bulletAScene = load("res://Entities/Bullets/BulletA.tscn")


func _ready():
	wahtNow()
	pass

func wahtNow():
	match(randi()%5):
		0:
			startWalking()
		1:
			$AnimationPlayer.play("rotate")
			moving = false
		2:
			$AnimationPlayer.play("open_fire")
		3:
			$AnimationPlayer.play("rotate")
			moving = false
		4:
			$AnimationPlayer.play("open_fire")

func startWalking():
	direction = Vector2(((randi()%2)*2)-1,((randi()%2)*2)-1) #pick a direction
	moving = true
	$TimerSleep.start()

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
	newBullet.global_position = global_position #+ Vector2(((randi()%2)*40)-20,((randi()%2)*40)-20)
	newBullet.linear_velocity= Vector2(((randi()%2)*2)-1,((randi()%2)*2)-1) *40* GM.BS
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

func _on_TimerDying_timeout():
	queue_free()

func _on_TimerSleep_timeout():
	wahtNow()

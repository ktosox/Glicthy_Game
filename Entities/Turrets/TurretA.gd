extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var GateNumber = 0

var target = Vector2()

var HP = 8

var bulletAScene = load("res://Entities/Bullets/BulletA.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	scanForPlayer()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func scanForPlayer():
	if($DetectionRange.get_overlapping_bodies() != []):
		setTarget()
		$Head.rotation = atan2( -GM.playerCurrent.global_position.x + global_position.x, GM.playerCurrent.global_position.y  -global_position.y) 
		$AnimationPlayer.play("fireTurret")
	else:
		$TimerCheckForPlayer.start()
	pass

func _on_TimerCheckForPlayer_timeout():
	scanForPlayer()
	pass # Replace with function body.


func fireBullet():
	var newBullet = bulletAScene.instance()
	newBullet.global_position = $Head/Line2D.global_position
	newBullet.linear_velocity= target * GM.BS
	get_parent().add_child(newBullet)

func pop():
	print("this should never hapen")


func setTarget():
	target = GM.playerCurrent.global_position - global_position
	target=Vector2( clamp(target.x, -GM.BS*10,GM.BS*10),clamp(target.y, -GM.BS*10,GM.BS*10))

func damange():
	HP -= 1
	if(HP<1):
		startDying()

func startDying():
	$HitBox.queue_free()
	$CollisionShape2D.queue_free()
	$TimerDying.start()
	$Head.modulate.a = 0.2

func _on_TimerDying_timeout():
	queue_free()
	pass # Replace with function body.


func _on_HitBox_body_entered(body):
	if(body.get_collision_layer_bit(0)):
		damange()
		body.pop()

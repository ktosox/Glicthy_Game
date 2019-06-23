extends Node2D

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
	if($DetectionRange.get_overlapping_bodies().find(GM.playerCurrent)!=-1):
		$AnimationPlayer.play("fireTurret")
	else:
		$TimerCheckForPlayer.start()

func _on_TimerCheckForPlayer_timeout():
	scanForPlayer()
	pass # Replace with function body.


func fireBullet():
	var newBullet = bulletAScene.instance()
	newBullet.global_position = $Head/Line2D.global_position
	newBullet.linear_velocity= target * GM.BS
	get_parent().add_child(newBullet)
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Resources/Sound/SFX/Enemy_Shoot.wav")
	player.set_bus("SFX")
	player.set_volume_db(-6.0)
	player.set_pitch_scale(3.0)
	player.play()

func pop():
	print("this should never hapen")


func setTarget():
	$Head.rotation = atan2( -GM.playerCurrent.global_position.x + global_position.x, GM.playerCurrent.global_position.y  -global_position.y)
	$Head.rotation += deg2rad(180)
	#print("Head rotation: ",$Head.rotation) 
	target.x = -sin(atan2(global_position.x - GM.playerCurrent.global_position.x, global_position.y - GM.playerCurrent.global_position.y)) *10*GM.BS
	target.y = -cos(atan2(global_position.x - GM.playerCurrent.global_position.x, global_position.y - GM.playerCurrent.global_position.y)) *10*GM.BS
	#print("target: ", target)

func damange():
	HP = HP - 1
	if(HP <= 0):
		startDying()

func startDying():
	if(GateNumber!=0):
		GM.openGate(GateNumber)
		GateNumber = 0
	$AnimationPlayer.stop()
	$HitBox.queue_free()
	$CollisionShape2D.queue_free()
	$TimerDying.start()
	$Head.modulate.a = 0

func _on_TimerDying_timeout():
	queue_free()
	pass # Replace with function body.


func _on_HitBox_body_entered(body):
	if(body.get_collision_layer_bit(0)):
		damange()
		body.pop()



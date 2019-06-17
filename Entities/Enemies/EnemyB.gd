extends KinematicBody2D

const MOTION_SPEED = 8 # Pixels/second
var counter = 0
var direction = Vector2()
var motion = Vector2()
var moving = false

var bulletAScene = load("res://Entities/Bullets/BulletA.tscn")


func _ready():
	startWalking()

#func _input(event):
#	if event.is_action_pressed("ui_accept"):
#		counter += 1
#		$Label.text = String(counter)

func _physics_process(delta):
	if(moving):
		motion = direction.normalized() * MOTION_SPEED
		move_and_collide(motion)
		
	
	
	

	

func startWalking():
	direction = Vector2((randf()*2)-1,(randf()*2)-1)
	moving = true
	$TimerMoving.start()
	pass


func stopWalking():
	moving = false
	var newBullet = bulletAScene.instance()
	newBullet.global_position = self.global_position
	get_parent().add_child(newBullet)
	$TimerStanding.start()
	pass


func _on_TimerMoving_timeout():
	stopWalking()
	pass # Replace with function body.


func _on_TimerStanding_timeout():
	startWalking()
	pass # Replace with function body.

extends KinematicBody2D

const MOTION_SPEED = 8 # Pixels/second
var counter = 0
var direction = Vector2()
var motion = Vector2()
var moving = false

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
	direction = Vector2(randf() - randf(),randf() - randf())
	moving = true
	$TimerMoving.start()
	pass


func stopWalking():
	moving = false
	$TimerStanding.start()
	pass


func _on_TimerMoving_timeout():
	stopWalking()
	pass # Replace with function body.


func _on_TimerStanding_timeout():
	startWalking()
	pass # Replace with function body.

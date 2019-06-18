extends KinematicBody2D

const MOTION_SPEED = 10 

var glitchOffset = Vector2()
var glitchState = 1

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		GM.pause_game()
	if event.is_action_pressed("ui_home"):
		pass

func _ready():
	GM.playerOriginal = self

func _physics_process(delta):
	glitchOffset.x = glitchOffset.x + delta * glitchState *10
	$Sprite.material.set_shader_param("offset",glitchOffset)
	if (glitchOffset.x>50.0):
		glitchState = -1
	if (glitchOffset.x<-50.0):
		glitchState = 1
	var motion = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		motion += Vector2(0, -1)
	if Input.is_action_pressed("ui_down"):
		motion += Vector2(0, 1)
	if Input.is_action_pressed("ui_left"):
		motion += Vector2(-1, 0)
	if Input.is_action_pressed("ui_right"):
		motion += Vector2(1, 0)
	
	motion = motion.normalized() * MOTION_SPEED

	move_and_collide(motion)


extends KinematicBody2D

const MOTION_SPEED = 10 

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		GM.pause_game()

func _ready():
	GM.playerOriginal = self

func _physics_process(delta):
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
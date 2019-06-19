extends KinematicBody2D


var bulletPlayerScene = load("res://Entities/Bullets/BulletPlayer.tscn")

const MOTION_SPEED = 10 




var glitchOffset = Vector2()
var glitchState = 1

func _input(event):
	if(event.is_class("InputEventMouseButton")):
		if(event.button_index == 1 && event.is_pressed()):
			fire_bullet()
	if event.is_action_pressed("ui_cancel"):
		GM.pause_game()
	if event.is_action_pressed("ui_home"):
		pass

func _ready():
	GM.playerCurrent = self

func _physics_process(delta):
	glitchOffset.x = glitchOffset.x + delta * glitchState *30
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
	
	$PlayerGun.rotation = atan2(get_global_mouse_position().x - global_position.x, global_position.y - get_global_mouse_position().y) - self.rotation

func fire_bullet():
	var newBullet = bulletPlayerScene.instance()
	newBullet.global_rotation = $PlayerGun.global_rotation
	newBullet.global_position = self.global_position
	newBullet.global_position.x += sin($PlayerGun.global_rotation) *80
	newBullet.global_position.y -= cos($PlayerGun.global_rotation) *80
	get_parent().add_child(newBullet)
	pass
extends KinematicBody2D

var bulletPlayerScene = load("res://Entities/Bullets/BulletPlayer.tscn")

var bombPlayerScene = load("")

var bulletReady = true

var phaseReady = true

var bombReady = true

var invunrability = false

var HP = 3

const MOTION_SPEED = 10 




var glitchOffset = Vector2()
var glitchState = 1

func _input(event):
	if(event.is_class("InputEventMouseButton")):
		if(event.button_index == 1 && event.is_pressed() && bulletReady):
			fire_bullet()
	if event.is_action_pressed("ui_cancel"):
		GM.pause_game()
	if event.is_action_pressed("skill_phase"):
		if(phaseReady):
			skillPhase()
		else:
			pass
	if event.is_action_pressed("skill_bomb"):
		if(bombReady):
			skillBomb()
		else:
			pass

func _ready():
	GM.playerCurrent = self
	


func _physics_process(delta):
#	glitchOffset.x = glitchOffset.x + delta * glitchState *30
#	$Sprite.material.set_shader_param("offset",glitchOffset)
#	if (glitchOffset.x>50.0):
#		glitchState = -1
#	if (glitchOffset.x<-50.0):
#		glitchState = 1
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


func skillPhase():
	print("PHASE!!!!!")
	set_collision_layer_bit(1,false)
	set_collision_mask_bit(3,false)
	set_collision_mask_bit(4,false)
	set_collision_mask_bit(5,false)
	set_collision_mask_bit(6,false)
	phaseReady = false
	$TimerPhaseCooldown.start()
	$Camera2D/Overlay.skillPhaseUsed()
	$Sprite.modulate.a = 0.4
	pass


func skillBomb():
	var newBomb = bombPlayerScene.instance()
	newBomb.global_position = global_position
	#seperate scene that fires a spray of bullets
	#an update to overlay that visualises skill cooldown goes here
	pass
	

func fire_bullet():
	bulletReady = false
	$TimerBulletCooldown.start()
	var newBullet = bulletPlayerScene.instance()
	newBullet.global_rotation = $PlayerGun.global_rotation
	newBullet.global_position = self.global_position
	newBullet.global_position.x += sin($PlayerGun.global_rotation) *70
	newBullet.global_position.y -= cos($PlayerGun.global_rotation) *70
	get_parent().add_child(newBullet)

func invunrableStart():

	
	invunrability = true

func invunrableStop():
	
	invunrability = false

func _on_TimerPhaseCooldown_timeout():
	set_collision_layer_bit(1,true)
	set_collision_mask_bit(3,true)
	set_collision_mask_bit(4,true)
	set_collision_mask_bit(5,true)
	set_collision_mask_bit(6,true)
	#code for exploding enemies player is standing in on materialisation goes here
	#make a thibk bullet scene, make it appear here
	phaseReady = true
	$Sprite.modulate.a = 1.0

func damange():
	GM.HP -=1
	#play invurability effect
	invunrableStart()
	updateHP()

func _on_HitBox_body_entered(body):
	if(body.get_collision_layer_bit(0) or body.get_collision_layer_bit(6)):
		if(!invunrability):
			damange()
			body.pop()


func pop():
	print("something tired to pop the player like a bullet - this shouldnt happen :(")

func updateHP():
	#update the value in overlay
	pass
	
func updateBossHP():
	#update the value in overlay
	pass

func _on_TimerBulletCooldown_timeout():
	bulletReady = true
	if(Input.is_mouse_button_pressed(1)):
		fire_bullet()

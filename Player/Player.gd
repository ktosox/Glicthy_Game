extends KinematicBody2D

var bulletPlayerScene = load("res://Entities/Bullets/BulletPlayer.tscn")

var bombPlayerScene = load("res://Player/Bomb.tscn")

var bulletReady = true

var phaseReady = true

var bombReady = true

var invunrability = false

var pauseReady = true

const MOTION_SPEED = 10

func _input(event):
	if(event.is_class("InputEventMouseButton")):
		if(event.button_index == 1 && event.is_pressed() && bulletReady):
			fire_bullet()
	if event.is_action_pressed("ui_cancel"):
		if(pauseReady):
			pauseReady = false
			$TimerPauseCooldown.start()
			GM.pause_game()
	if event.is_action_pressed("skill_phase"):
		if(phaseReady):
			skillPhase()
	if event.is_action_pressed("skill_bomb"):
		if(bombReady):
			skillBomb()

func _ready():
	GM.playerCurrent = self

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
	
	$PlayerGun.rotation = atan2(get_global_mouse_position().x - global_position.x, global_position.y - get_global_mouse_position().y) - self.rotation


func skillPhase():

	phaseReady = false
	$TimerPhaseCooldown.start()
	$Camera2D/Overlay.skillPhaseUsed()
	invunrableStart()
	$AnimationPlayer.play("skillPhase")
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Resources/Sound/SFX/Phase_Ability.wav")
	player.set_bus("SFX")
	player.set_volume_db(-6.0)
	player.play()


func skillBomb():
	var newBomb = bombPlayerScene.instance()
	newBomb.global_position = global_position
	newBomb.global_rotation = $PlayerGun.global_rotation
	get_parent().add_child(newBomb)
	bombReady = false
	$Camera2D/Overlay.skillBombUsed()
	$TimerBombCooldown.start()
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Resources/Sound/SFX/Explosion_Ability.wav")
	player.set_bus("SFX")
	player.set_volume_db(-6.0)
	player.play()

func fire_bullet():
	bulletReady = false
	$TimerBulletCooldown.start()
	var newBullet = bulletPlayerScene.instance()
	newBullet.global_rotation = $PlayerGun.global_rotation
	newBullet.global_position = self.global_position
	newBullet.global_position.x += sin($PlayerGun.global_rotation) *70
	newBullet.global_position.y -= cos($PlayerGun.global_rotation) *70
	get_parent().add_child(newBullet)
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Resources/Sound/SFX/Player_Shoot.wav")
	player.set_bus("SFX")
	player.set_volume_db(-6.0)
	player.play()

func invunrableStart():
	invunrability = true
	set_collision_layer_bit(1,false)
	set_collision_mask_bit(3,false)
	set_collision_mask_bit(4,false)
	set_collision_mask_bit(5,false)
	set_collision_mask_bit(6,false)

func invunrableStop():
	invunrability = false
	set_collision_layer_bit(1,true)
	set_collision_mask_bit(3,true)
	set_collision_mask_bit(4,true)
	set_collision_mask_bit(5,true)
	set_collision_mask_bit(6,true)

func _on_TimerPhaseCooldown_timeout():
	phaseReady = true

func damange():
	GM.playerHP -= 1
	if(GM.playerHP <= 0):
		GM.lose_game()
	$AnimationPlayer.play("damangeFlash")
	invunrableStart()
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Resources/Sound/SFX/Player_Damage.wav")
	player.set_bus("SFX")
	player.set_volume_db(4.0)
	player.pitch_scale = 0.5
	player.play()
	updateHP(GM.playerHP)

func _on_HitBox_body_entered(body):
	if(body.get_collision_layer_bit(4) or body.get_collision_layer_bit(6)):
		if(!invunrability):
			damange()
			body.pop()


func pop():
	print("something tired to pop the player like a bullet - this shouldnt happen :(")

func updateHP(newHP):
	$Camera2D/Overlay.updatePlayerHP(newHP)
	
func updateBossHP(newBossHP):
	$Camera2D/Overlay.updateBossHP(newBossHP)

func _on_TimerBulletCooldown_timeout():
	bulletReady = true
	if(Input.is_mouse_button_pressed(1)):
		fire_bullet()


func _on_TimerBombCooldown_timeout():
	bombReady = true

func _on_TimerPauseCooldown_timeout():
	pauseReady = true

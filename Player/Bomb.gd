extends RigidBody2D

var lifeTime = 12
var speed = 200

var bulletPlayerScene = load("res://Entities/Bullets/BulletPlayer.tscn")


func _ready():
	linear_velocity = Vector2(sin(self.rotation),-cos(self.rotation)) * speed
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func fireBullet(var volume = -6.0):
	var newBullet = bulletPlayerScene.instance()
	newBullet.global_rotation = $Sprite.global_rotation
	newBullet.global_position = $Sprite/Position2D.global_position
	get_parent().add_child(newBullet)
	var player = AudioStreamPlayer2D.new()
	self.add_child(player)
	player.stream = load("res://Resources/Sound/SFX/Player_Shoot.wav")
	player.set_bus("SFX")
	player.set_volume_db(volume)
	player.play()

func explode():
	$Sprite.queue_free()
	var angle = 12
	while (angle > 0):
		angle -=1
		fireBullet(-17.0)
		global_rotation+=4
	$TimerDying.start()

func _on_TimerFire_timeout():
	if(lifeTime<0):
		explode()
		$TimerFire.stop()
	else:
		fireBullet()
		lifeTime -= 1
	pass # Replace with function body.


func _on_TimerDying_timeout():
	self.queue_free()
	pass # Replace with function body.
	

func pop():
	print("bomb was poped, why?")

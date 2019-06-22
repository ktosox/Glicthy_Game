extends RigidBody2D

var lifeTime = 12
var speed = 250

var bulletPlayerScene = load("res://Entities/Bullets/BulletPlayer.tscn")


func _ready():
	linear_velocity = Vector2(sin(self.rotation),-cos(self.rotation)) * speed
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func fireBullet():
	var newBullet = bulletPlayerScene.instance()
	newBullet.global_rotation = $Sprite.global_rotation
	newBullet.global_position = $Sprite/Position2D.global_position
	get_parent().add_child(newBullet)

func explode():
	$TimerDying.start()
	pass

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

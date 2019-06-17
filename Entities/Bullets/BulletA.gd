extends RigidBody2D

var speed = 120

# Called when the node enters the scene tree for the first time.
func _ready():
	self.linear_velocity = Vector2((randf()*2)-1,(randf()*2)-1) * speed
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LifeTimer_timeout():
	$placeholder.visible = false
	$ExplosionA.emitting = true
	$BulletCore.queue_free()
	$DeathTimer.start()



func _on_DeathTimer_timeout():
	self.queue_free()

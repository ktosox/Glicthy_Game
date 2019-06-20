extends RigidBody2D

var speed = 120

func _ready():
	self.linear_velocity = Vector2((randf()*2)-1,(randf()*2)-1) * speed


func _on_LifeTimer_timeout():
	$placeholder.visible = false
	$ExplosionA.emitting = true
	$DeathTimer.start()


func _on_DeathTimer_timeout():
	queue_free()

func pop():
	queue_free()
	pass

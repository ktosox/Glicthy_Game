extends RigidBody2D

var speed = 360

var alive = true

func _ready():
	self.linear_velocity = Vector2((randf()*2)-1,(randf()*2)-1) * speed

func _on_LifeTimer_timeout():
	dying()

func dying():
	if(alive):
		$placeholder.visible = false
		$ExplosionA.emitting = true
		$DeathTimer.start()
	alive = false

func _on_DeathTimer_timeout():
	queue_free()

func pop():
	dying()
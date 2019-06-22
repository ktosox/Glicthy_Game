extends RigidBody2D

var speed = 40

var alive = true

func _ready():
	self.apply_impulse(Vector2(), Vector2((randf()*2)-1,(randf()*2)-1) * speed)

func _on_LifeTimer_timeout():
	dying()

func dying():
	if(alive):
		$placeholder.visible = false
		$CollisionShape2D.queue_free()
		$DeathTimer.start()
	alive = false

func _on_DeathTimer_timeout():
	queue_free()

func pop():
	dying()
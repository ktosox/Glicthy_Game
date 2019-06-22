extends RigidBody2D

var speed = 70

var alive = true

func _ready():
	self.apply_impulse(Vector2(), Vector2((randf()*2)-1,(randf()*2)-1) * speed)


func pop():
	queue_free()

func _on_BulletA_body_entered(body):
	pop()

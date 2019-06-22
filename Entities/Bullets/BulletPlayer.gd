extends RigidBody2D

var speed = 900


func _ready():
	linear_velocity = Vector2(sin(self.rotation),-cos(self.rotation)) * speed


func pop():
	queue_free()

func _on_BulletPlayer_body_entered(body):
	pop()

extends RigidBody2D

var speed = 500
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	linear_velocity = Vector2(sin(self.rotation),-cos(self.rotation)) * speed
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BulletPlayer_body_entered(body):
	print(body)
	pass # Replace with function body.


func _on_TimerDeath_timeout():
	self.queue_free()
	pass # Replace with function body.


func pop():
	queue_free()
	pass
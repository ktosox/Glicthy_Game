extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
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

extends Area2D

export var GateNumber = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Platform_body_entered(body):
	if(body.get_collision_layer_bit(1) and GateNumber != 0):
		GM.openGate(GateNumber)
		$Sprite.modulate = $Sprite.modulate.inverted()
		$CollisionShape2D.queue_free()

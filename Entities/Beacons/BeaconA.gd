extends Node2D



export var GateNumber = 0

var HP = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.



func damange():
	print("oyuch")
	HP -= 1
	if (HP<0):
		#$TimerDying.start()
		if(GateNumber != 0):
			GM.openGate(GateNumber)
			GateNumber = 0


func _on_DetectionRange_body_entered(body):
	if(body.get_collision_layer_bit(0)):
		damange()
		body.pop()
	pass # Replace with function body.


func _on_TimerDying_timeout():
	self.queue_free()
	pass # Replace with function body.

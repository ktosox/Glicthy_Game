extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var GateNumber = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if(GateNumber != 0):
		GM.addGate(GateNumber, self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func openGate():
	self.queue_free()
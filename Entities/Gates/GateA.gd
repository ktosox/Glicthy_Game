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
	$CollisionShape2D.queue_free()
	$Polygon2D.modulate.a = 0.1
	var player = AudioStreamPlayer2D.new()
	self.add_child(player)
	player.stream = load("res://Resources/Sound/SFX/Gate_Open.wav")
	player.set_bus("SFX")
	player.set_volume_db(-6.0)
	player.play()
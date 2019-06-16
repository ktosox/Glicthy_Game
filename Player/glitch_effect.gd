extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var targetTexture
var targetSet = false

# Called when the node enters the scene tree for the first time.
func _ready():
	glitch()
	pass # Replace with function body.

func glitch():
	if (!targetSet):
		targetTexture = get_parent().get_texture()
		targetSet=true
		$Cyan.texture = targetTexture
		$Magenta.texture = targetTexture
	$AnimationPlayer.play("glitchSlide")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	updatePlayerHP(GM.playerHP)
	if(GM.firstGo):
		$Tutorial.visible = true
		$TimerTutorial.start()
		GM.firstGo = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func updateBossHP(HP):
	$VBoxContainer/Container/ProgressBar.value = HP
	pass

func showBossHP():
	$VBoxContainer/Container/ProgressBar.visible = true
	pass

func hideBossHP():
	$VBoxContainer/Container/ProgressBar.visible = false
	pass

func updatePlayerHP(HP):
	$VBoxContainer/Container/Panel/CenterContainer/HBoxContainer/HP.text = String(HP)
	

func skillPhaseUsed():
	$VBoxContainer/CenterContainer/Panel/HBoxContainer/SkillPhase/AnimationPlayer.play("used")
	pass

func skillPhaseReady():
	pass
	
func skillBombUsed():
	$VBoxContainer/CenterContainer/Panel/HBoxContainer/Skill2/AnimationPlayer.play("used")
	pass
	
func skillBombReady():
	
	pass



func _on_TimerTutorial_timeout():
	$Tutorial.visible = false
	pass # Replace with function body.

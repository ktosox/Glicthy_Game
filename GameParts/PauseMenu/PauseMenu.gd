extends Control


func _on_Button_return_pressed():
	get_tree().paused = false
	self.queue_free()


func _on_Button_moar_pressed():
	print("MOAR MOAR MOARMOAR MOAR MOAR MOAR")
	GM.BS += 1


func _on_Button_exit_pressed():
	get_tree().quit()
	pass

extends Control

func _input(event):
	if Input.is_action_pressed('quit'):
		Global.play_random_sound("TurnSounds")
		if get_tree().change_scene("res://Splash.tscn") != OK:
			print ("An unexpected error occured when trying to switch to the Readme scene")

	else:
		if not (event is InputEventMouseMotion):
			Global.play_random_sound("TurnSounds")
			if get_tree().change_scene("res://Main.tscn") != OK:
				print ("An unexpected error occured when trying to switch to the Readme scene")
	

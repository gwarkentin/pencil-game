extends Control

func _input(event):
	if Input.is_action_pressed('quit'):
		if get_tree().change_scene("res://Splash.tscn") != OK:
			print ("An unexpected error occured when trying to switch to the Readme scene")
	
	else:
		if not (event is InputEventMouseMotion):
			if get_tree().change_scene("res://Main.tscn") != OK:
				print ("An unexpected error occured when trying to switch to the Readme scene")
	

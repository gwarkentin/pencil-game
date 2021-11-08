extends Control

func _input(event):
	if Input.is_action_pressed('quit'):
		get_tree().change_scene("res://Splash.tscn")
	else:
		if not (event is InputEventMouseMotion):
			get_tree().change_scene("res://Main.tscn")

extends Control

func _input(event):
	if not (event is InputEventMouseMotion) and not (event.is_action("left") or event.is_action("right") or event.is_action("up") or event.is_action("down")):
		if get_tree().change_scene("res://Splash.tscn") != OK:
			print ("An unexpected error occured when trying to switch to the Readme scene")

extends Control

var count = 0.0

func _input(_event):
	if Input.is_action_pressed('quit'):
		get_tree().quit()

func _on_Play_pressed():
	Global.play_random_sound("TurnSounds")
	if get_tree().change_scene("res://Controls.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the Readme scene")
	

func _on_Credits_pressed():
	Global.play_random_sound("TurnSounds")
	if get_tree().change_scene("res://Credits.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the Readme scene")


func _on_Exit_pressed():
	Global.play_random_sound("CrumpleSounds")
	get_tree().quit()


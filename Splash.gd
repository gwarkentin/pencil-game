extends Control

var count = 0.0

func _input(event):
	if Input.is_action_pressed('quit'):
		get_tree().quit()

func _on_Play_pressed():
	get_tree().change_scene("res://Controls.tscn")

func _on_Credits_pressed():
	get_tree().change_scene("res://Credits.tscn")

func _on_Exit_pressed():
	get_tree().quit()


extends Control

var current_type = "box"

func _on_box_pressed():
	current_type = "box"

func _on_balloon_pressed():
	current_type = "balloon"

func _on_ramp_pressed():
	current_type = "ramp"

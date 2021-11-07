extends Control

signal changetype(new_type)

func _on_Button_box_pressed():
	emit_signal("changetype", "box")

func _on_Button_balloon_pressed():
	emit_signal("changetype", "balloon")

func _on_Button_rope_pressed():
	emit_signal("changetype", "rope")
	
func _on_Button_ramp_pressed():
	emit_signal("changetype", "ramp")


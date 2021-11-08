extends Control

signal changing_types(new_type)

func _on_box_pressed():
	 emit_signal("changing_types","box")

func _on_balloon_pressed():
	emit_signal("changing_types","balloon")

func _on_ramp_pressed():
	emit_signal("changing_types","ramp")


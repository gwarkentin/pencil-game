extends Control

signal changing_types(new_type)

func _clear_buttons(new_type):
	emit_signal("changing_types",new_type)
	var butts = $Butts.get_children()
	for button in butts:
		if button.name != new_type:
			button.pressed = false
		else:
			if button.pressed:
				button.pressed = false

func _on_box_button_down():
	_clear_buttons("box")

func _on_balloon_button_down():
	_clear_buttons("balloon")
	
func _on_ramp_button_down():
	_clear_buttons("ramp")

func _on_erase_button_down():
	_clear_buttons("erase")

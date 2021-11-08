extends Control

func _input(event):
	if Input.is_action_pressed('quit'):
		get_tree().quit()
		
	if not (event is InputEventMouseMotion):
		$Background2.visible = false
	
func _on_Play_pressed():
	get_tree().change_scene("res://Main.tscn")

func _on_Credits_pressed():
	$Background2.visible = true

func _on_Exit_pressed():
	get_tree().quit()

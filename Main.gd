extends Node

var counter = 0.0
var hud_offset = Vector2()
export (PackedScene) var box
export (PackedScene) var balloon
export (PackedScene) var rope
export (PackedScene) var ramp
var types

func _ready():
	var types = {
			"box" : box,
			"balloon" : balloon,
			"rope": rope,
			"ramp": ramp
			}
	hud_offset = $HUD.get_global_position() -$Player.get_global_position()
	
func _process(delta):
	$Camera2D.set_global_position($Player.get_global_position())
	$HUD.set_global_position(Vector2($Player.get_global_position() - $HUD.get_size() / 2).floor())
	counter += delta
	if counter > 2:
		counter = 0
		$HUD/MarginContainer/VBoxContainer/HBoxContainer/Health.value -= 1
		$HUD/MarginContainer/VBoxContainer/HBoxContainer/Graphite.value -= 5
		
func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		var target = event.position
		_spawn_fake_object("box", target)
		
func _spawn_fake_object(type, target):
	var new_obj = box.instance()
	new_obj.position = target
	add_child(new_obj)

extends Node

var counter = 0.0
var hud_offset = Vector2()
export (PackedScene) var box
export (PackedScene) var balloon
export (PackedScene) var rope
export (PackedScene) var ramp
var current_type = "box"

func _ready():
	hud_offset = $HUD.get_global_position() -$Player.get_global_position()
	
func _process(delta):
	$Camera2D.set_global_position($Player.get_global_position())
	$HUD.set_global_position(Vector2($Player.get_global_position() - $HUD.get_size() / 2 + Vector2(0, -30)).floor())
	counter += delta
	if counter > 2:
		counter = 0
		$HUD/MarginContainer/VBoxContainer/HBoxContainer/Health.value -= 1
		$HUD/MarginContainer/VBoxContainer/HBoxContainer/Graphite.value -= 5
		
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var target = get_viewport().get_mouse_position() + $Camera2D.position - Vector2(get_viewport().size / 2).floor()
		print(target)
		_spawn_fake_object(target)
		
func _spawn_fake_object(target):
	var new_obj = box.instance()
	match current_type:
		"box":
			new_obj = box.instance()
		"balloon":
			new_obj = balloon.instance()
		"rope":
			new_obj = rope.instance()
		"ramp":
			new_obj = ramp.instance()	
	new_obj.position = target
	add_child(new_obj)

func _change_current_type(new_type):
	current_type = new_type

func _on_HUD_changetype(new_type):
	_change_current_type(new_type)

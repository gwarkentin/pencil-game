extends Node2D

var counter = 0.0
var hud_offset = Vector2()
export (PackedScene) var box
export (PackedScene) var balloon
export (PackedScene) var ramp
var new_obj

func _ready():
	hud_offset = $Camera2D.get_global_position() - $HUD.get_global_position()
	
func _process(delta):
	$Camera2D.set_global_position($Player.get_global_position())
	$HUD.set_global_position($Camera2D.get_global_position() - hud_offset)
	counter += delta
	if counter > 2:
		counter = 0
		$HUD/Health.value -= 1
		$HUD/Graphite.value -= 5
		
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var target = get_global_mouse_position()
		_spawn_fake_object(target)
		
func _spawn_fake_object(target):
	print($HUD.current_type)
	match $HUD.current_type:
		"box":
			new_obj = box.instance()
		"balloon":
			new_obj = balloon.instance()
		"ramp":
			new_obj = ramp.instance()
		null:
			new_obj = null
			
	if new_obj:
		new_obj.position = target
		self.add_child(new_obj)


	

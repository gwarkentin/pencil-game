extends Node2D

var counter = 0.0
var hud_offset = Vector2()
export (PackedScene) var box
export (PackedScene) var balloon
export (PackedScene) var ramp
export (int) var max_objects = 10
var new_obj
var clicked_deadzone = false
var erasable_mask = 0b0010
export (float) var manaspeed = 5.0
var current_type

func _ready():
	hud_offset = $Camera2D.get_global_position() - $HUD.get_global_position()
	
func _process(delta):
	$Camera2D.set_global_position($Player.get_global_position())
	$HUD.set_global_position($Camera2D.get_global_position() - hud_offset)
	$HUD/Graphite.value += manaspeed * delta
	
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var target = get_global_mouse_position()
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(target, target + Vector2(0.1,0.1), [self],erasable_mask)
		if current_type == "erase":
			if result:
				_erase_item(instance_from_id(result["collider_id"]))
		else:
			if target.x > $HUD.get_global_position().x + 500:
				_spawn_fake_object(target)
			


func _spawn_fake_object(target):
	match current_type:
		"box":
			new_obj = box.instance()
		"balloon":
			new_obj = balloon.instance()
		"ramp":
			new_obj = ramp.instance()
		"erase", null:
			new_obj = null

	if new_obj and $HUD/Graphite.value - new_obj.manacost >= 0:
		new_obj.position = target
		$DrawnStuff.add_child(new_obj)
		$HUD/Graphite.value -= new_obj.manacost
		var relative_dir = target - $Player.get_global_position()
		$Player._draw_or_erase(relative_dir)
		
	if $DrawnStuff.get_child_count() > max_objects:
		$DrawnStuff.get_child(0).queue_free()

func _erase_item(item):
	var relative_dir = item.get_global_position() - $Player.get_global_position()
	$Player._draw_or_erase(relative_dir, true)
	$HUD/Graphite.value += item.manacost
	item.queue_free()
	

func _on_HUD_changing_types(new_type):
	current_type = new_type


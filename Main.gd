extends Node2D

var counter = 0.0
var hud_offset = Vector2()
export (PackedScene) var box
export (PackedScene) var balloon
export (PackedScene) var ramp
export (PackedScene) var eraser
export (int) var max_objects = 10
var new_obj
var clicked_deadzone = false
export (float) var manaspeed = 5.0
var current_type

func _ready():
	hud_offset = $Camera2D.get_global_position() - $HUD.get_global_position()
	
func _process(delta):
	$Camera2D.set_global_position($Player.get_global_position())
	$HUD.set_global_position($Camera2D.get_global_position() - hud_offset)
	$HUD/Graphite.value += manaspeed * delta
	
func _input(event):
	if Input.is_action_pressed('quit'):
		Global.play_random_sound("CrumpleSounds")
		if get_tree().change_scene("res://Splash.tscn") != OK:
			print ("An unexpected error occured when trying to switch to the Readme scene")
		
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var target = get_global_mouse_position()
		if target.x > $HUD.get_global_position().x + 500:
			_spawn_fake_object(target)

func _spawn_fake_object(target):
	var erasing = false
	match current_type:
		"box":
			new_obj = box.instance()
		"balloon":
			new_obj = balloon.instance()
		"ramp":
			new_obj = ramp.instance()
		"erase":
			new_obj = eraser.instance()
			new_obj.connect("return_graphite", self, "_return_graphite")
			erasing = true
		null:
			new_obj = null

	if new_obj:
		new_obj.position = target
		var relative_dir = target - $Player.get_global_position()
		if $HUD/Graphite.value - new_obj.manacost >= 0:
			if erasing:
				add_child(new_obj)
			else:
				$DrawnStuff.add_child(new_obj)
			$HUD/Graphite.value -= new_obj.manacost
			$Player._draw_or_erase(relative_dir, erasing)
		
	if $DrawnStuff.get_child_count() > max_objects:
		$DrawnStuff.get_child(0).queue_free()


func _return_graphite(manacost):
	$HUD/Graphite.value += manacost
	

func _on_HUD_changing_types(new_type):
	current_type = new_type
	if current_type == "erase":
		$Player.idle = "_erase"
	else:
		$Player.idle = ""


func _on_Map_goal(body):
	if body.name == "Player":
		Global.play_random_sound("TurnSounds")
		if get_tree().change_scene("res://Credits.tscn") != OK:
			print ("An unexpected error occured when trying to switch to the Readme scene")


func _on_Player_take_damage(amount):
	$HUD/Health.value -= amount
	if $HUD/Health.value <= 0:
		Global.play_random_sound("CrumpleSounds")
		if get_tree().change_scene("res://Credits.tscn") != OK:
			print ("An unexpected error occured when trying to switch to the Readme scene")


func _on_Map_deal_damage(body, amount):
	body._take_damage(amount)

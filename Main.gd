extends Node

var counter = 0.0
var hud_offset = Vector2()

func _ready():
	hud_offset = $HUD.get_global_position() -$Player.get_global_position()
	
func _process(delta):
	$Camera2D.set_global_position($Player.get_global_position())
	$HUD.set_global_position($Player.get_global_position() + hud_offset/2)

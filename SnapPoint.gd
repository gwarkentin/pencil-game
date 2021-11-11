extends Node2D

var connected_to
var break_speed = 1800

func _try_connect(body):
	if not connected_to:
		connected_to = body
		return true
	return false


extends Area2D

export (int) var manacost = 5
var firstframe = true

signal return_graphite(amount)

func _process(_delta):
	if not firstframe:
		queue_free()
	else:
		firstframe = false
	
func _on_Eraser_body_entered(body):
	emit_signal("return_graphite", body.manacost)
	body.queue_free()
	queue_free()

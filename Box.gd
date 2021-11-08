extends RigidBody2D

export (int) var manacost = 25

signal maybe_erase(item)

func _on_Box_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("maybe_erase", self)

func _ready():
	var sound = $Sounds.get_children()[rand_range(0,$Sounds.get_child_count())]
	sound.play()

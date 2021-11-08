extends RigidBody2D

func _ready():
	var sound = $Sounds.get_children()[rand_range(0,$Sounds.get_child_count())]
	sound.play()
	

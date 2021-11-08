extends Node2D

export (int) var GRAVITY = 1200
var velocity = Vector2(0,0)

var connected = false
var connected_to

func _ready():
	var sound = $Sounds.get_children()[rand_range(0,$Sounds.get_child_count())]
	sound.play()

func _physics_process(delta):
	velocity.y -= GRAVITY * delta
	velocity = $Balloon.move_and_slide(velocity, Vector2.UP)
	velocity = $Rope.move_and_slide(velocity, Vector2.UP)

func _on_Balloon_body_entered(body):
	if not connected:
		match body.name:
			"Player", "Box":
				connected = true
				connected_to = body
	

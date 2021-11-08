extends Node2D

export (int) var GRAVITY = 1200
export (int) var manacost = 25

var velocity = Vector2(0,0)

var connected = false
var connected_to

signal maybe_erase(item)

func _on_Balloon_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("maybe_erase", self)
		
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
	

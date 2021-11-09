extends KinematicBody2D

export (int) var GRAVITY = 1200
export (int) var manacost = 25

var velocity = Vector2(0,0)

var connected = false
var connected_to
	
func _ready():
	var sound = $Sounds.get_children()[rand_range(0,$Sounds.get_child_count())]
	sound.play()

func _physics_process(delta):
	velocity.y -= GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _take_damage(_amount):
	queue_free()

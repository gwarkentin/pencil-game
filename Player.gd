extends KinematicBody2D

export (int) var MOVE_SPEED = 400
export (int) var JUMP_SPEED = -500
export (int) var GRAVITY = 1200
var velocity = Vector2()
var jumping = false
var counter = 0

func _ready():
	$AnimatedJump.show()
	$AnimatedSprite.hide()

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('right')
	var left = Input.is_action_pressed('left')
	var jump = Input.is_action_just_pressed('jump')

	if jump and is_on_floor():
		jumping = true
		velocity.y = JUMP_SPEED
		$AnimatedJump.frame = 0
		$AnimatedJump.play()
	if right:
		velocity.x += MOVE_SPEED
		$AnimatedSprite.scale.x = 1
	if left:
		velocity.x -= MOVE_SPEED
		$AnimatedSprite.scale.x = -1

	
func _physics_process(delta):
	get_input()
		
	velocity.y += GRAVITY * delta
	
	
	if jumping and is_on_floor():
		jumping = false
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	

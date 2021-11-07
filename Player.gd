extends KinematicBody2D

export (int) var MOVE_SPEED = 400
export (int) var JUMP_SPEED = -500
export (int) var GRAVITY = 1200
var velocity = Vector2()
var jumping = false
var crouching = false
var counter = 0

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('right')
	var left = Input.is_action_pressed('left')
	var crouch = Input.is_action_just_pressed('jump')
	var jump = Input.is_action_just_released('jump')

	if crouching and jump and is_on_floor():
		jumping = true
		$AnimatedSprite.play('jump')
		crouching = false
		velocity.y += JUMP_SPEED
		
	if crouch and is_on_floor():
		crouching = true
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0
		$AnimatedSprite.animation = 'crouch'
	else:
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
		$AnimatedSprite.play('idle')
	
	if crouching:
		velocity.x = 0
		
	if not jumping and velocity.x != 0:
		$AnimatedSprite.play('walk')
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	

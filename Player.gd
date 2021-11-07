extends KinematicBody2D

export (int) var MOVE_SPEED = 400
export (int) var JUMP_SPEED = -500
export (int) var GRAVITY = 1200
var velocity = Vector2()
var jumping = false
var jump_time = 0.0
var crouching = false
var counter = 0

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('right')
	var left = Input.is_action_pressed('left')
	var crouch = Input.is_action_just_pressed('jump')
	var jump = Input.is_action_just_released('jump')
	
	if crouch and is_on_floor():
		crouching = true
	else:
		if right:
			velocity.x += MOVE_SPEED
			$AnimatedSprite.scale.x = 1
		if left:
			velocity.x -= MOVE_SPEED
			$AnimatedSprite.scale.x = -1
	
	if crouching and jump and is_on_floor():
		jumping = true
		jump_time = 0
		crouching = false
		velocity.y += JUMP_SPEED
		

func _physics_process(delta):
	get_input()
	velocity.y += GRAVITY * delta
	
	_switch_animation()
	
	if crouching:
		velocity.x = 0
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, 0.785398, false)

	if jumping:
		jump_time += delta
		if jump_time > delta * 5:
			if is_on_floor():
				jumping = false

	
func _switch_animation():
	if crouching:
		$AnimatedSprite.play('crouch')
	elif jumping:
		$AnimatedSprite.play('jump')
	elif velocity.x == 0:
		$AnimatedSprite.play('idle')
	else:
		$AnimatedSprite.play('walk')

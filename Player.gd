extends KinematicBody2D

export (int) var MOVE_SPEED = 1200
export (int) var JUMP_SPEED = -1400
export (int) var GRAVITY = 1200 * 2
var velocity = Vector2()
var jumping = false
var jump_time = 0.0
var crouching = false
var counter = 0
var drawing = false
var idle = ""

var taking_damage = false
var falling = false
var last_on_floor = 0.0

signal take_damage(amount)

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('right')
	var left = Input.is_action_pressed('left')
	var crouch = Input.is_action_just_pressed('up')
	var jump = Input.is_action_just_released('up')
	
	if crouch and is_on_floor():
		crouching = true
	else:
		if right:
			velocity.x += MOVE_SPEED
			$AnimatedSprite.scale.x = 1
		if left:
			velocity.x -= MOVE_SPEED
			$AnimatedSprite.scale.x = -1
	
	if crouching:
		if is_on_floor():
			if jump:
				jumping = true
				jump_time = 0
				crouching = false
				velocity.y += JUMP_SPEED
		else:
			crouching = false
			
		

func _physics_process(delta):
	if is_on_floor():
		if falling:
			emit_signal("take_damage", ceil(last_on_floor/ 8))
			taking_damage = true
		last_on_floor = 0.0
		falling = false
		
	last_on_floor += delta * 5
	if last_on_floor >= 8:
		falling = true
	
	get_input()
	velocity.y += GRAVITY * delta
	if not drawing:
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
	if taking_damage:
		$AnimatedSprite.play("damage")
	elif falling:
		$AnimatedSprite.play('falling')
	elif crouching:
		$AnimatedSprite.play('crouch' + idle)
	elif jumping:
		$AnimatedSprite.play('jump' + idle)
	elif velocity.x == 0:
		$AnimatedSprite.play('idle' + idle)
	else:
		$AnimatedSprite.play('walk' + idle)

func _draw_or_erase(relative_dir, erase = false):
	drawing = true
	if relative_dir.x > 0:
		$AnimatedSprite.scale.x = 1
	else:
		$AnimatedSprite.scale.x = -1
	
	if erase:
		if relative_dir.y > -300:
			$AnimatedSprite.play('erase_front')
		else:
			$AnimatedSprite.play('erase_above')
		var sound = $EraseSounds.get_children()[rand_range(0,$EraseSounds.get_child_count())]
		sound.play()
	else:
		if relative_dir.y > -300:
			$AnimatedSprite.play('draw_front')
		else:
			$AnimatedSprite.play('draw_above')

func _draw_done():
	drawing = false
	taking_damage = false

func _on_AnimatedSprite_animation_finished():
	_draw_done()
	

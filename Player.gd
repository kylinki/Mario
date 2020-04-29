extends KinematicBody2D

const ACCELERATION = 50
const GRAVITY = 20
const JUMP_HEIGHT = -400
const MAX_SPEED = 200
const UP = Vector2(0, -1)

var motion = Vector2()

func _physics_process(delta):
	var friction = false
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("Run")
	else:
		motion.x = 0
		$AnimatedSprite.play("Idle")
		friction = true
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		$AnimatedSprite.play("Jump")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
		
	motion = move_and_slide(motion, UP)

extends KinematicBody2D

const UP = Vector2(0, -1)
const MOVESPEED = 150
const JUMP = -500
const GRAVITY = 10

var attacking = false
var motion = Vector2()
var timer = null

func _ready():
	pass	

func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_key_pressed(KEY_Z):
		$AnimatedSprite.play("attack")
		attacking = true
	else:
		attacking = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = MOVESPEED
		if attacking == false:
			$AnimatedSprite.play("move")
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		motion.x = -MOVESPEED
		if attacking == false:
			$AnimatedSprite.play("move")
		$AnimatedSprite.flip_h = true
	#elif _input(event) == True:
	#	print("Attack")
	else:
		motion.x = 0
		if attacking == false:
			$AnimatedSprite.play("idle")
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
				motion.y = JUMP

	motion = move_and_slide(motion, UP)

func _input(ev):
	if Input.is_key_pressed(KEY_Z):
		return true
	else:
		return false
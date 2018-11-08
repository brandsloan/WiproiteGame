extends KinematicBody2D

const GRAVITY = 10
const MOVESPEED = 150
const UP = Vector2(0, -1)
const attackRange = 50
const JUMP = -400

var velocity = Vector2()
var direction = 1
var distance2Player = 0

var attacking = false
var vision = true
var idling = false
var activating = false

var enemyPos = Vector2()
var playerPos = Vector2()

var uPos = Vector2()
var dPos = Vector2()
var ePos = Vector2()

func _ready():
	$AnimatedSprite.play("idle")
	uPos = $UpCast.position
	dPos = $DownCast.position
	ePos = $Eyeline.position

func _physics_process(delta):
	
	if vision == false:
		idling = true
		$AnimatedSprite.play("idle")
		if $Eyeline.is_colliding() == true:
			idling = false
			vision = true
	else:
		enemyPos = $CollisionShape2D.global_position
		playerPos = get_owner().get_node("Player").get_node("CollisionShape2D").global_position
		if(get_owner() != null):
			distance2Player = enemyPos.distance_to(playerPos)
			
		if distance2Player < 80:
			print("attacking")
			attacking = true
		else:
			attacking = false
			if enemyPos.x - playerPos.x > 0:
				idling = false
				direction = -1
			elif enemyPos.x - playerPos.x < 0:
				direction = 1
				idling = false
			else:
				idling = true
			if enemyPos.y - playerPos.y > 10 and $UpCast.is_colliding() == false:
				print("option1")
				if is_on_floor():
					velocity.y = JUMP
			elif enemyPos.y > playerPos.y and $UpCast.is_colliding() == true:
				print("option2")
				#player above, but celing in the way
				#direction *= -1
				#turn around to find opening
			elif enemyPos.y < playerPos.y and $DownCast.is_colliding() == false:
				print("option3")
				#continue
			elif enemyPos.y < playerPos.y and $DownCast.is_colliding() == true:
				print("option4")
				if is_on_wall():
					velocity.y = JUMP
			
		if direction == 1:
			$AnimatedSprite.flip_h = false
			$UpCast.position.x = uPos.x * -1
			$DownCast.position.x = dPos.x * -1
			$Eyeline.position.x = ePos.x * -1
		else:
			$AnimatedSprite.flip_h = true
			$UpCast.position.x = uPos.x 
			$DownCast.position.x = dPos.x
			$Eyeline.position.x = ePos.x 
		#print($UpCast.position.x)
		#velocity.x = MOVESPEED * direction #tobe removed
		#$AnimatedSprite.play("move")
		if attacking == false and idling == false:
			$AnimatedSprite.play("move")
			velocity.x = MOVESPEED * direction
		elif attacking == false and idling == true:
			$AnimatedSprite.play("idle")
			velocity.x = 0
		else:
			$AnimatedSprite.play("attack")
			velocity.x = 0
				
		print(distance2Player)
		velocity.y += GRAVITY
		
		velocity = move_and_slide(velocity, UP)
		
		if is_on_wall():
			#direction *= -1
			pass
		#if $DownCast.is_colliding() == false:
		#	direction *= -1
		#	print($DownCast.position.x)
		#	$UpCast.position.x *= -1
		#	$DownCast.position.x *= -1
		
			

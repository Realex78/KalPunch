extends CharacterBody2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var jump_speed = -5000
var jump_acum = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerAnimatedSprite.animation = "idle"


func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		jump_acum += min(delta * jump_speed, -100)

	if Input.is_action_just_released("jump") and is_on_floor():
		velocity.y = max(jump_acum, -1001)
		jump_acum = 0
	
	# Get the input direction.
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed
	
	$PlayerAnimatedSprite.flip_h = velocity.x < 0
	if is_on_floor():
		if velocity.x != 0:
			$PlayerAnimatedSprite.animation = "walk"
			$PlayerAnimatedSprite.flip_v = false
		else:
			$PlayerAnimatedSprite.animation = "idle"
	else:
		if velocity.y > 0:
			$PlayerAnimatedSprite.animation = "falling"
		else:
			$PlayerAnimatedSprite.animation = "jump"

	move_and_slide()
	
	#
	#if !is_on_floor():
		#velocity.y += gravity
		#if velocity.y > 100:
			#velocity.y = 100
	#
	#if Input.is_action_pressed("move_right"):
		#velocity.x += 1
	#if Input.is_action_pressed("move_left"):
		#velocity.x -= 1
	#
	#if velocity.length() > 0:
		#velocity = velocity.normalized() * speed
		#if velocity.x != 0:
			#$PlayerAnimatedSprite.animation = "walk"
			#$PlayerAnimatedSprite.flip_v = false
			## See the note below about boolean assignment.
			#$PlayerAnimatedSprite.flip_h = velocity.x < 0
	#else:
		#$PlayerAnimatedSprite.animation = "idle"
	#
	#move_and_slide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#var velocity = Vector2.ZERO # The player's movement vector.
	#
#
	#if velocity.length() > 0:
		#velocity = velocity.normalized() * speed
		#if velocity.x != 0:
			#$PlayerAnimatedSprite.animation = "walk"
			#$PlayerAnimatedSprite.flip_v = false
			## See the note below about boolean assignment.
			#$PlayerAnimatedSprite.flip_h = velocity.x < 0
	#else:
		#$PlayerAnimatedSprite.animation = "idle"
		#
	#position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
	

extends CharacterBody2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var jump_speed = -5000
var jump_acum = 0
var last_velocity_y = 0
var PLAYER_ID = 0
var last_pressed_jump = true
# Time since landing initialized to inifity for comparison purposes
var time_since_landing = INF
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isattacking= false;
var damaged=0

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerAnimatedSprite.animation = "idle"
	$PlayerAnimatedSprite.flip_v = false

func _on_PlayerHitRadiusCollision(area):
	if area.is_in_group("player"):
		damaged=damaged+1
		$PlayerAnimatedSprite.animation="smacked"


func _physics_process(delta):
	# Puro input alv
	# Handle Jump.
	var pressed_jump = (Input.is_joy_button_pressed(PLAYER_ID, JOY_BUTTON_A) or Input.is_joy_button_pressed(PLAYER_ID, JOY_BUTTON_DPAD_UP))
	if pressed_jump and is_on_floor() and isattacking==false:
		jump_acum += min(delta * jump_speed, -100)
		

	if last_pressed_jump and !pressed_jump and is_on_floor() and isattacking==false:
		velocity.y = max(jump_acum, -1001)
		jump_acum = 0
	else:
		# Add the gravity.
		velocity.y += gravity * delta
	
	# Get the input direction.
	var direction = Input.get_joy_axis(PLAYER_ID, JOY_AXIS_LEFT_X)
	if direction < 0.1 and direction > -0.1:
		velocity.x = 0
	else:
		velocity.x = direction * speed
		
	
	# Editar animaciones
	$PlayerAnimatedSprite.flip_h = velocity.x < 0
	if is_on_floor():
		isattacking=false
		if Input.get_joy_axis(PLAYER_ID, JOY_AXIS_TRIGGER_RIGHT) > 0.25:
			$PlayerAnimatedSprite.animation = "punch"
			isattacking=true
		elif last_velocity_y > velocity.y:
			$PlayerAnimatedSprite.animation = "landing"
			time_since_landing = 0
		elif time_since_landing < 0.25:
			time_since_landing += delta
		elif velocity.x != 0 and isattacking==false:
			$PlayerAnimatedSprite.animation = "walk"
		else:
			$PlayerAnimatedSprite.animation = "idle"
	else:
		if velocity.y > 0 and isattacking==false:
			$PlayerAnimatedSprite.animation = "falling"
		else:
			$PlayerAnimatedSprite.animation = "jump"
		

	last_velocity_y = velocity.y
	last_pressed_jump = pressed_jump

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
	

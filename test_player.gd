extends CharacterBody2D

@export var speed = 300
@export var gravity = 30

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 500:
			velocity.y = 500
	
	var horizontal_direction = Input.get_axis("D-pad(Left)","D-pad(Right)")
	
	velocity.x = speed * horizontal_direction
	
	move_and_slide()

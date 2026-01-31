extends CharacterBody2D

@export var speed: float = 300.0

func _physics_process(delta: float) -> void:
	# Get input direction
	var input_vector = Vector2.ZERO
	
	if Input.is_action_pressed("Move Right"):
		input_vector.x += 1
	if Input.is_action_pressed("Move Left"):
		input_vector.x -= 1
	if Input.is_action_pressed("Move Down"):
		input_vector.y += 1
	if Input.is_action_pressed("Move Up"):
		input_vector.y -= 1
	
	# Normalize the input vector to prevent faster diagonal movement
	input_vector = input_vector.normalized()
	
	# Set velocity
	velocity = input_vector * speed * delta
	
	# Move the character
	move_and_slide()

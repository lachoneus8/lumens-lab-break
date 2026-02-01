class_name LightReactiveEntity
extends CharacterBody2D

@export var light_range: float = 115.0
@export var move_speed: float = 50.0
@export var direction_change_time: float = 2.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var stationary_sprite: Sprite2D = $StationarySprite2D

var move_direction: Vector2 = Vector2.ZERO
var time_until_direction_change: float = 0.0
var is_near_light: bool = false

func _ready():
	randomize()
	change_direction()

func _physics_process(delta: float) -> void:
	update_nearest_light_distance()
	
	if should_move():
		handle_movement(delta)
	else:
		stop_movement()

func update_nearest_light_distance():
	var lights = get_tree().get_nodes_in_group("lights")
	var nearest_distance: float = INF
	
	for light in lights:
		if light is Node2D:
			var distance = global_position.distance_to(light.global_position)
			if distance < nearest_distance:
				nearest_distance = distance
	
	is_near_light = nearest_distance <= light_range

func should_move() -> bool:
	# Override in derived classes
	return false

func handle_movement(delta: float):
	time_until_direction_change -= delta
	
	if time_until_direction_change <= 0:
		change_direction()
	
	velocity = move_direction * move_speed
	move_and_slide()
	
	# Update sprites
	animated_sprite.visible = true
	stationary_sprite.visible = false
	animated_sprite.play()

func stop_movement():
	velocity = Vector2.ZERO
	
	# Update sprites
	animated_sprite.visible = false
	stationary_sprite.visible = true
	animated_sprite.stop()

func change_direction():
	# Random direction
	var angle = randf() * TAU
	move_direction = Vector2(cos(angle), sin(angle)).normalized()
	
	# Random time until next direction change
	time_until_direction_change = direction_change_time + randf() * direction_change_time

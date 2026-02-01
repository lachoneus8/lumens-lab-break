extends Node2D

@export var lock: Lock
@export var textureOn: Texture
@export var textureOff: Texture

@onready var sound_player: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
@onready var plate_activated_sound = preload("res://Audio/pressure_plate_activated_filmcow.wav")
@onready var plate_deactivated_sound = preload("res://Audio/pressure_plate_deactivated_filmcow.wav")

var bodies_on_plate: int = 0

func _ready():
	print("PressurePlate ready! Lock assigned: ", lock != null)

func _on_body_entered(body: Node2D) -> void:
	print("Body entered pressure plate: ", body.name, " from ", body.get_parent().name)
	bodies_on_plate += 1
	
	if bodies_on_plate == 1 and lock:
		lock.unlock_door()
		get_parent().get_node("Sprite2D").texture = textureOn
		sound_player.stream = plate_activated_sound
		sound_player.play()
	elif not lock:
		print("WARNING: No lock assigned to pressure plate!")


func _on_body_exited(body: Node2D) -> void:
	print("Body exited pressure plate: ", body.name, " from ", body.get_parent().name)
	bodies_on_plate -= 1
	
	if bodies_on_plate <= 0 and lock:
		bodies_on_plate = 0  # Ensure it doesn't go negative
		lock.lock_door()
		get_parent().get_node("Sprite2D").texture = textureOff
		sound_player.stream = plate_deactivated_sound
		sound_player.play()
	else:
		print("WARNING: No lock assigned to pressure plate!")

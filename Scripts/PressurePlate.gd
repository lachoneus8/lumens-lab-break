extends Node2D

@export var lock: Lock
@export var textureOn: Texture
@export var textureOff: Texture

@onready var sound_player: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
@onready var plate_activated_sound = preload("res://Audio/pressure_plate_activated_filmcow.wav")
@onready var plate_deactivated_sound = preload("res://Audio/pressure_plate_deactivated_filmcow.wav")

func _ready():
	print("PressurePlate ready! Lock assigned: ", lock != null)

func _on_body_entered(body: Node2D) -> void:
	print("Area entered pressure plate: ", body.name, " from ", body.get_parent().name)
	if lock:
		lock.unlock_door()
		get_parent().get_node("Sprite2D").texture = textureOn
		sound_player.stream = plate_activated_sound
		sound_player.play()
	else:
		print("WARNING: No lock assigned to pressure plate!")


func _on_body_exited(body: Node2D) -> void:
	print("Area exited pressure plate: ", body.name, " from ", body.get_parent().name)
	if lock:
		lock.lock_door()
		get_parent().get_node("Sprite2D").texture = textureOff
		sound_player.stream = plate_deactivated_sound
		sound_player.play()
	else:
		print("WARNING: No lock assigned to pressure plate!")

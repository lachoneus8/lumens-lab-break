class_name Door
extends Node2D

@export var textureClosed: Texture
@export var textureOpen: Texture

@onready var sound_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var door_open_close_sound = preload("res://Audio/door_open_close_filmcow.wav")

func _ready() -> void:
	sound_player.stream = door_open_close_sound

func open():
	$StaticBody2D/CollisionShape2D.disabled = true
	$Sprite2D.texture = textureOpen

	
	sound_player.play()
	
func close():
	$StaticBody2D/CollisionShape2D.disabled = false
	$Sprite2D.texture = textureClosed

	sound_player.play()

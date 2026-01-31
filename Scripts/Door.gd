class_name Door
extends Node2D

@export var textureClosed: Texture
@export var textureOpen: Texture

func open():
	$StaticBody2D/CollisionShape2D.disabled = true
	$Sprite2D.texture = textureOpen
	
	
func close():
	$StaticBody2D/CollisionShape2D.disabled = false
	$Sprite2D.texture = textureClosed

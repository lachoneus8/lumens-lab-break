class_name Door
extends Node2D

func open():
	$StaticBody2D/CollisionShape2D.disabled = true
	$Sprite2D.visible = false
	
func close():
	$StaticBody2D/CollisionShape2D.disabled = false
	$Sprite2D.visible = true

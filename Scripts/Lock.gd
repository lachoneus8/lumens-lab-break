class_name Lock
extends Node2D

@export var door: Door

func unlock_door():
	door.open()

func lock_door():
	door.close()

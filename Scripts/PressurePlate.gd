extends Node2D

@export var lock: Lock
@export var textureOn: Texture
@export var textureOff: Texture

func _ready():
	print("PressurePlate ready! Lock assigned: ", lock != null)

func _on_body_entered(body: Node2D) -> void:
	print("Area entered pressure plate: ", body.name, " from ", body.get_parent().name)
	if lock:
		lock.unlock_door()
		get_parent().get_node("Sprite2D").texture = textureOn
	else:
		print("WARNING: No lock assigned to pressure plate!")


func _on_body_exited(body: Node2D) -> void:
	print("Area exited pressure plate: ", body.name, " from ", body.get_parent().name)
	if lock:
		lock.lock_door()
		get_parent().get_node("Sprite2D").texture = textureOff
	else:
		print("WARNING: No lock assigned to pressure plate!")

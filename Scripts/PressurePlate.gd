extends Node2D

@export var lock: Lock

func _ready():
	print("PressurePlate ready! Lock assigned: ", lock != null)

func _on_body_entered(body: Node2D) -> void:
	print("Area entered pressure plate: ", body.name, " from ", body.get_parent().name)
	if lock:
		lock.unlock_door()
	else:
		print("WARNING: No lock assigned to pressure plate!")


func _on_body_exited(body: Node2D) -> void:
	print("Area exited pressure plate: ", body.name, " from ", body.get_parent().name)
	if lock:
		lock.lock_door()
	else:
		print("WARNING: No lock assigned to pressure plate!")

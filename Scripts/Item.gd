extends Node2D

@export var itemData: ItemData

func _ready():
	if itemData:
		$Sprite2D.texture = itemData.texture

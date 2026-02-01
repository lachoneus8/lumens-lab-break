extends Control

func _ready():
	# Connect back button
	$BackButton.pressed.connect(_on_back_pressed)
	
	# Set scale to 1.0 for credits screen
	get_window().content_scale_factor = 1.0

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

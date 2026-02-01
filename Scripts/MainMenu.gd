extends Control

func _ready():
	# Set scale to 1.0 for main menu
	get_window().content_scale_factor = 1.0
	
	# Start animations
	$CenterContainer/VBoxContainer/TitleContainer/LumenSprite.play()
	$MouseSprite.play()
	$StatueSprite.play()
	
	# Connect button signals
	$VBoxContainer/PlayButton.pressed.connect(_on_play_pressed)
	$VBoxContainer/CreditsButton.pressed.connect(_on_credits_pressed)

func _on_play_pressed():
	# Set scale to 4.0 for gameplay
	get_window().content_scale_factor = 4.0
	# Change to the game scene
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")

func _on_credits_pressed():
	# Change to credits scene
	get_tree().change_scene_to_file("res://Scenes/Credits.tscn")

extends Area2D

@onready var completion_ui = $CompletionUI

func _ready():
	body_entered.connect(_on_body_entered)
	completion_ui.visible = false
	# Allow UI to process when game is paused
	completion_ui.process_mode = Node.PROCESS_MODE_ALWAYS

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Lumen":
		show_completion_screen()

func show_completion_screen():
	completion_ui.visible = true
	get_tree().paused = true

func _on_return_to_menu_pressed():
	get_tree().paused = false
	get_window().content_scale_factor = 1.0
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

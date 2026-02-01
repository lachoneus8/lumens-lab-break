extends Area2D

@export var title_text: String = "Level Complete!"
@export var message_text: String = "You escaped the lab!"
@export var button_text: String = "Return to Menu"
@export var destination_scene: String = "res://Scenes/MainMenu.tscn"

@onready var completion_ui = $CompletionUI

func _ready():
	body_entered.connect(_on_body_entered)
	completion_ui.visible = false
	# Allow UI to process when game is paused
	completion_ui.process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Set custom text
	$CompletionUI/CenterContainer/VBoxContainer/Title.text = title_text
	$CompletionUI/CenterContainer/VBoxContainer/Message.text = message_text
	$CompletionUI/CenterContainer/VBoxContainer/ReturnButton.text = button_text

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Lumen":
		show_completion_screen()

func show_completion_screen():
	completion_ui.visible = true
	get_tree().paused = true

func _on_return_to_menu_pressed():
	get_tree().paused = false
	get_window().content_scale_factor = 1.0
	get_tree().change_scene_to_file(destination_scene)

extends CanvasLayer

func _ready():
	visible = false

func show_menu():
	visible = true
	get_tree().paused = true

func hide_menu():
	visible = false
	get_tree().paused = false

func _on_resume_pressed():
	hide_menu()

func _on_restart_pressed():
	hide_menu()
	get_tree().reload_current_scene()

func _on_main_menu_pressed():
	hide_menu()
	get_window().content_scale_factor = 1.0
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _on_quit_pressed():
	get_tree().quit()

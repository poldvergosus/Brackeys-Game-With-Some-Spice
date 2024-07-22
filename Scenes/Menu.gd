extends Control

@onready var button_manager = $Button_manager
@onready var option_menu = $Option_menu

func _physics_process(delta):
	if (button_manager.visible == false and option_menu.visible == false):
		button_manager.visible =true

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_option_pressed():
	button_manager.visible = false
	option_menu.visible = true

func _on_quit_pressed():
	print("quit pressed")
	get_tree().quit()

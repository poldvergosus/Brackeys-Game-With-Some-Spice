extends Control

@onready var option_menu = $"."

func _on_volume_m_value_changed(value):
	AudioServer.set_bus_volume_db(0,linear_to_db(value))

func _on_volume_s_value_changed(value):
	AudioServer.set_bus_volume_db(1,linear_to_db(value))

func _on_volume_sfx_value_changed(value):
	AudioServer.set_bus_volume_db(2,linear_to_db(value))

func _on_button_pressed():
	option_menu.visible = false
	

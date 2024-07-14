extends Area2D

@onready var timer = $Timer
@onready var dead_sound = $deadSound



func _on_body_entered(body):
	if body is CharacterBody2D:
		body.die()  # Вызываем функцию смерти персонажа
		dead_sound.play()
		timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()


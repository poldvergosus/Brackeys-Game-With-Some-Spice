extends Node2D

@onready var video_stream_player = $VideoStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	video_stream_player.connect("finished", Callable(self, "_on_video_finished"))

func _on_video_finished():
	print("Видео закончилось, закрываем игру")
	get_tree().quit()

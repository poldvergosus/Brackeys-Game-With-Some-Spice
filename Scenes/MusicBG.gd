extends AudioStreamPlayer2D
@onready var audio_stream_player_2d = $"."

func _ready():
	audio_stream_player_2d.max_distance = 20000000

func stop_global_audio():
	audio_stream_player_2d.stop()

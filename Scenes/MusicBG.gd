extends AudioStreamPlayer2D
@onready var audio_stream_player_2d = $"."

func stop_global_audio():
	audio_stream_player_2d.stop()

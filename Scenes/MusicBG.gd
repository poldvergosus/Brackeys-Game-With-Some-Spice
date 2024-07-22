extends AudioStreamPlayer
@onready var audio_stream_player = $".."

func stop_global_audio():
	audio_stream_player.stop()

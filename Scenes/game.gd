extends Node2D
@onready var music = %Music


# Called when the node enters the scene tree for the first time.
func _ready():
	$Music.play(MusicWillLive.musicProgress) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

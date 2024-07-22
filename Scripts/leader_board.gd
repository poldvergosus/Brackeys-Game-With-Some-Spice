extends Node

@onready var label = $Label

const SAVEFILE = "user://savefile.save"

var highest_record: float = 0

func _on_ready():
	load_score()
	label.text = str(highest_record)
	
func save_score():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE_READ)
	file.store_32(highest_record)
	
func load_score():
	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
	if FileAccess.file_exists(SAVEFILE):
		highest_record = file.get_32()







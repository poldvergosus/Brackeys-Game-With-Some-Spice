extends Node

var score: int = 0
@onready var score_label = $score_label
@onready var score_label_2 = $score_label2
var next_level_path = "res://Scenes/Final.tscn"

func death_label_update():
	DeathCounter.add_death_count()
	update_death_label()

func add_coin():
	score += 1
	score_label.text = "Собрано монет:" + str(score) + " из 30"
	if score == 30:
		change_to_next_level()

func update_death_label():
	var current_deaths = DeathCounter.death_count
	score_label_2.text = "Смертей: " + str(current_deaths)

func change_to_next_level():
	MusicBg.stop_global_audio()
	get_tree().change_scene_to_file(next_level_path)

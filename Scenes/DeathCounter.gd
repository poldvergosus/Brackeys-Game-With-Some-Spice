extends Node

var death_count: int = 0

func add_death_count():
	death_count += 1
	print("Игрок умер " + str(death_count) + " раз")
	return death_count

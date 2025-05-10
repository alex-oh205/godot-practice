extends Node

var slow_terrain = [0, 10, 20, 30, 7, 8, 17, 18]
var current_level = 0
var levels = ["res://ui/TitleScreen.tscn", "res://maps/Multiplayer.tscn"]

func restart():
	current_level = 0
	get_tree().change_scene(levels[current_level])
	
func next_level():
	current_level += 1
	print("level", current_level)
	if current_level < levels.size():
		get_tree().change_scene(levels[current_level])
	else:
		restart()
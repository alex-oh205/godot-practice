extends Node2D

var units = {"Mech": preload("res://Mech.tscn"),
			"Ship": preload("res://Ship.tscn")}
			
func _ready():
	randomize()
	

func _on_Timer_timeout():
	var u = units.keys()[randi() % 2]
	var m = units[u].instance()
	$YSort.add_child(m)
	if u == "Mech":
		m.position.y = rand_range(400, 562)
	elif u == "Ship":
		m.position.y = rand_range(40, 275)

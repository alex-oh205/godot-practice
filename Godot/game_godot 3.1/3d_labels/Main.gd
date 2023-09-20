extends Spatial

var Mob = preload("res://Mob.tscn")

func _ready():
	randomize()

func _on_Timer_timeout():
	var m = Mob.instance()
	add_child(m)
	m.start($Position3D.transform)
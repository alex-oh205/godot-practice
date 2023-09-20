extends Node2D

# Shows debug data.

var font = load("res://font_roboto_16.tres")
export(NodePath) var camera
export(NodePath) var player


func _process(delta):
	update()
	
	
func _draw():
	var cam = get_node(camera)
	var p = get_node(player)
	draw_string(font, Vector2(20, 20), "touches: " + str(cam.events.size()), Color(1, 1, 1))
	draw_string(font, Vector2(20, 50), "zoom: " + str(cam.zoom), Color(1, 1, 1))
	for touch in cam.events.values():
		draw_circle(touch.position, 50, Color(1, 1, 0, 0.2))
		if touch is InputEventScreenDrag:
			draw_line(touch.position, touch.position+touch.relative*10, Color(1, 0, 0), 5)

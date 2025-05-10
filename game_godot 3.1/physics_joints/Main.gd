extends Node2D

var Ball = load("res://Ball.tscn")

#func _process(delta):
#	if Input.is_mouse_button_pressed(BUTTON_LEFT):
#		var b = Ball.instance()
#		b.position = get_global_mouse_position()
#		add_child(b)
			
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT:
			var b = Ball.instance()
			b.position = event.position
			add_child(b)
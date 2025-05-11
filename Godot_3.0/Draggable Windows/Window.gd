extends TextureRect

signal move_to_top

var drag_position = null

func _ready():
	hint_tooltip = name

func _on_Window_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			# star dragging
			drag_position = get_global_mouse_position() - rect_global_position
			emit_signal('move_to_top', self)
		else:
			# end dragging
			drag_position = null
	if event is InputEventMouseMotion and drag_position:
		rect_global_position = get_global_mouse_position() - drag_position
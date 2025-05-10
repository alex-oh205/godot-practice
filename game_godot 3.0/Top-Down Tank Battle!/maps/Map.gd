extends Node2D

func _ready():
	Input.set_custom_mouse_cursor(load("res://assets/UI/crossair_black.png"), Input.CURSOR_ARROW, Vector2(16, 16))
	$Player_1.map = $Ground
	$Player_2.map = $Ground

func _on_Tank_shoot(bullet, _position, _direction, _target=null):
	var b = bullet.instance()
	add_child(b)
	b.start(_position, _direction, _target)

func _on_Player_1_dead():
	GLOBALS.restart()

func _on_Player_2_dead():
	GLOBALS.restart()
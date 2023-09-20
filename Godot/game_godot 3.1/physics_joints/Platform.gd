extends RigidBody2D

func _ready():
	$CollisionPolygon2D.polygon = $Polygon2D.polygon
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed:
		apply_impulse(event.position - position, Vector2.UP * 1000)
extends RigidBody2D

export (int) var engine_thrust
export (int) var spin_thrust

var thrust = Vector2()
var rotation_dir = 0
var screensize

func _ready():
	screensize = get_viewport().get_visible_rect().size

func get_input():
	if Input.is_action_pressed("ui_up"):
		thrust = Vector2(engine_thrust, 0)
	else:
		thrust = Vector2()
	rotation_dir = 0
	if Input.is_action_pressed("ui_right"):
		rotation_dir += 1
	if Input.is_action_pressed("ui_left"):
		rotation_dir -= 1
		
func _process(delta):
	get_input()

#func _physics_process(delta):
#	set_applied_force(thrust.rotated(rotation))
#	set_applied_torque(rotation_dir * spin_thrust)

func _integrate_forces(state):
	set_applied_force(thrust.rotated(rotation))
	set_applied_torque(rotation_dir * spin_thrust)
	var xform = state.get_transform()
	if xform.origin.x > screensize.x:
		xform.origin.x = 0
	if xform.origin.x < 0:
		xform.origin.x = screensize.x
	if xform.origin.y > screensize.y:
		xform.origin.y = 0
	if xform.origin.y < 0:
		xform.origin.y = screensize.y
	state.set_transform(xform)
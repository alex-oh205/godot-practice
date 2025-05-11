#
# A Simple wasd-qe camera
#
# ~/wip1/godot/projects3/repo-gdscripts
#
#extends Camera
extends Spatial


export var flyspeed= 1.0
export var view_sensitivity = 0.1
export var runspeed = 4.0

var yaw = 0
var pitch = 0

func _ready():
	var deg = rad2deg(get_global_transform().basis.get_euler().y)
	yaw = fmod(-deg, 360)
	deg = rad2deg(get_global_transform().basis.get_euler().x)
	pitch = max(min(deg, 90), -90)

func _enter_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _exit_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(e):
	if e.is_action_pressed("ui_cancel"):
		get_tree().quit()

	if e is InputEventMouseMotion:
		yaw = fmod(yaw - e.relative.x * view_sensitivity, 360)
		pitch = max(min( pitch - e.relative.y * view_sensitivity, 90), -90)
		set_rotation(Vector3(deg2rad(pitch), 0, 0))
		global_rotate(Vector3(0, 1, 0), deg2rad(yaw))


func _process(delta):
	var t = get_transform()
	var extra_speed = runspeed
	if(Input.is_key_pressed(KEY_SHIFT)):
		extra_speed = 1
	if(Input.is_key_pressed(KEY_W)):
		t.origin -= t.basis.z * flyspeed * extra_speed * delta
		set_transform(t)
	if(Input.is_key_pressed(KEY_S)):
		t.origin -= -t.basis.z * flyspeed * extra_speed * delta
		set_transform(t)
	if(Input.is_key_pressed(KEY_A)):
		t.origin -= t.basis.x * flyspeed * extra_speed * delta
		set_transform(t)
	if(Input.is_key_pressed(KEY_D)):
		t.origin -= -t.basis.x * flyspeed * extra_speed * delta
		set_transform(t)
	if(Input.is_key_pressed(KEY_Q)):
		t.origin -= t.basis.y * flyspeed * extra_speed * delta
		set_transform(t)
	if(Input.is_key_pressed(KEY_E)):
		t.origin -= -t.basis.y * flyspeed * extra_speed * delta
		set_transform(t)

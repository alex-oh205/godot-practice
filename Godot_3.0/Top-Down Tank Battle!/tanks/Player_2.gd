extends "res://tanks/Tank.gd"

export var id = 0
export var turret_speed = 0

func control(delta):
	var rot_dir = 0
	if Input.is_action_pressed('right_%s' % id):
		rot_dir += 1
	if Input.is_action_pressed('left_%s' % id):
		rot_dir -= 1
	rotation += rotation_speed * rot_dir * delta
	velocity = Vector2()
	if Input.is_action_pressed('forward_%s' % id):
		velocity += Vector2(max_speed, 0).rotated(rotation)
	if Input.is_action_pressed('back_%s' % id):
		velocity += Vector2(-max_speed, 0).rotated(rotation)
		velocity /= 2.0
	if Input.is_action_pressed('turret_turn_right'):
		var current_dir = Vector2(1, 0).rotated($Turret.global_rotation)
		$Turret.global_rotation += 1 * turret_speed * delta
	if Input.is_action_pressed('turret_turn_left'):
		var current_dir = Vector2(1, 0).rotated($Turret.global_rotation)
		$Turret.global_rotation += -1 * turret_speed * delta
	if Input.is_action_just_pressed('click_%s' % id):
		shoot(gun_shots, gun_spread)
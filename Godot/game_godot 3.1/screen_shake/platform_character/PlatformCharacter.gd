extends KinematicBody2D

export (int) var speed = 1200
export (int) var jump_speed = -1800
export (int) var gravity = 4000
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

var velocity = Vector2.ZERO

func _ready():
	add_inputs()
	
func add_inputs():
	# add input actions (for portability)
	var ev
	if !InputMap.has_action("walk_right"):
		InputMap.add_action("walk_right")
		ev = InputEventKey.new()
		ev.scancode = KEY_RIGHT
		InputMap.action_add_event("walk_right", ev)
	if !InputMap.has_action("walk_left"):
		InputMap.add_action("walk_left")
		ev = InputEventKey.new()
		ev.scancode = KEY_LEFT
		InputMap.action_add_event("walk_left", ev)
	if !InputMap.has_action("jump"):
		InputMap.add_action("jump")
		ev = InputEventKey.new()
		ev.scancode = KEY_UP
		InputMap.action_add_event("jump", ev)
	
	
func get_input():
	var dir = 0
	if Input.is_action_pressed("walk_right"):
		dir += 1
	if Input.is_action_pressed("walk_left"):
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
		
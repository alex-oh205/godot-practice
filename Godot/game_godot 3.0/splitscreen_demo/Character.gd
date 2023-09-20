extends KinematicBody2D

export var id = 0
export var speed = 250

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('right_%s' % id):
		velocity.x += 1
	if Input.is_action_pressed('left_%s' % id):
		velocity.x -= 1
	if Input.is_action_pressed('up_%s' % id):
		velocity.y -= 1
	if Input.is_action_pressed('down_%s' % id):
		velocity.y += 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
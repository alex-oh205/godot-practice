extends Area2D

var state_machine
var life = 3

func _ready():
	state_machine = get_parent().get_node("AnimationTree").get("parameters/playback")

func take_damage():
	if life > 0:
		life -= 1
		state_machine.travel("hit")
	if life == 0:
		state_machine.travel("break")
		$CollisionShape2D.set_disabled(true)
	print("Barrel	%s" % life)
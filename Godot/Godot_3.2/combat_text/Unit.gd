extends Area2D

export var health = 100
export var speed = 100
var dir
var spawns = [0, -50, 1074]


func _ready():
	dir = pow(-1, randi() % 2)
	speed *= dir
	$AnimatedSprite.flip_h = dir < 0
	position.x = spawns[dir]
	#position.y = rand_range(400, 562)
	

func _process(delta):
	position.x += speed * delta


func _on_Unit_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT:
			var dmg = randi() % 10 + 1
			var crit = true if randi() % 100 < 10 else false
			if crit:
				dmg *= 2
			take_damage(dmg)
			$FCTMgr.show_value(dmg, crit)


func take_damage(value):
	health -= value
	if health <= 0:
		$CollisionShape2D.disabled = true
		speed = 0
		$AnimatedSprite.play("explode")
		yield(get_tree().create_timer(0.5), "timeout")
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

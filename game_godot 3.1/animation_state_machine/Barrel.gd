extends StaticBody2D

var life

func _process(delta):
	if $HurtBox/CollisionShape2D.is_disabled():
		$Body.set_disabled(true)
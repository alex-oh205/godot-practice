extends KinematicBody2D

onready var parent = get_parent()

signal shoot
signal health_changed
signal ammo_changed
signal dead

export (PackedScene) var Bullet
export (int) var max_speed
export (float) var rotation_speed
export (float) var gun_cooldown
export (int) var max_health
export (float) var offroad_friction

export (int) var gun_shots = 1
export (float, 0, 1.5) var gun_spread = 0.2
export (int) var max_ammo = 20
export (int) var ammo = -1 setget set_ammo
export (float) var turret_speed
export (int) var detect_radius

var velocity = Vector2()
var can_shoot = true
var alive = true
var health
var map

var speed = 0
var target = null

func _ready():
	health = max_health
	$Smoke.emitting = false
	emit_signal('health_changed', health * 100/max_health)
	emit_signal('ammo_changed', ammo * 100/max_ammo)
	$GunTimer.wait_time = gun_cooldown
	var circle = CircleShape2D.new()
	$DetectRadius/CollisionShape2D.shape = circle
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius

func control(delta):
	if parent is PathFollow2D:
		if $LookAhead1.is_colliding() or $LookAhead2.is_colliding():
			speed = lerp(speed, 0, 0.1)
		else:
			speed = lerp(speed, max_speed, 0.05)
		parent.set_offset(parent.get_offset() + speed * delta)
		position = Vector2()
	else:
		# other movement code
		pass

func shoot(num, spread, target=null):
	if can_shoot and ammo != 0:
		self.ammo -= 1
		can_shoot = false
		$GunTimer.start()
		var dir = Vector2(1, 0).rotated($Turret.global_rotation)
		if num > 1:
			for i in range(num):
				var a = -spread + i * (2*spread)/(num-1)
				emit_signal('shoot', Bullet, $Turret/Muzzle.global_position, dir.rotated(a), target)
				emit_signal('shoot', Bullet, $Turret2/Muzzle.global_position, dir.rotated(a), target)
		else:
			emit_signal('shoot', Bullet, $Turret/Muzzle.global_position, dir, target)
			emit_signal('shoot', Bullet, $Turret2/Muzzle.global_position, dir, target)
		$AnimationPlayer.play('muzzle_flash')
		$AnimationPlayer.play('muzzle_flash2')

func _physics_process(delta):
	if not alive:
		return
	control(delta)
	if map:
		var tile = map.get_cellv(map.world_to_map(position))
		if tile in GLOBALS.slow_terrain:
			velocity *= offroad_friction
	move_and_slide(velocity)

func take_damage(amount):
	health -= amount
	emit_signal('health_changed', health * 100/max_health)
	if health < max_health / 2:
		$Smoke.emitting = true
	if health <= 0:
		explode()

func heal(amount):
	health += amount
	health = clamp(health, 0, max_health)
	emit_signal('health_changed', health * 100/max_health)
	if health >= max_health / 2:
		$Smoke.emitting = false
	
func explode():
	$CollisionShape2D.disabled = true
	alive = false
	$Turret.hide()
	$Body.hide()
	$Explosion.show()
	$Explosion.play()
	emit_signal('dead')
	
func set_ammo(value):
	if value > max_ammo:
		value = max_ammo
	ammo = value
	emit_signal('ammo_changed', ammo * 100/max_ammo)

func _process(delta):
	if target:
		var target_dir = (target.global_position - global_position).normalized()
		var current_dir = Vector2(1, 0).rotated($Turret.global_rotation)
		$Turret.global_rotation = current_dir.linear_interpolate(target_dir, turret_speed * delta).angle()
		$Turret2.global_rotation = current_dir.linear_interpolate(target_dir, turret_speed * delta).angle()
		if target_dir.dot(current_dir) > 0.9:
			shoot(gun_shots, gun_spread, target)

func _on_GunTimer_timeout():
	can_shoot = true
	
func _on_Explosion_animation_finished():
	queue_free()

func _on_DetectRadius_body_entered(body):
	target = body

func _on_DetectRadius_body_exited(body):
	if body == target:
		target = null
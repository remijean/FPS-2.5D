extends Control

var isShooting = false

onready var animation_player := $AnimationPlayer

const PROJECTILE = preload("res://scenes/projectile/projectile.tscn")

func _on_Player_shoot(weapon, muzzle, ray_cast, _delta):
	# Do nothing if the weapon is not used
	if weapon != name:
		pass
	
	# Shoot
	if !isShooting:
		isShooting = true
		# Projectile
		var projectile = PROJECTILE.instance()
		projectile.speed = 0.2
		projectile.damage = 5
		projectile.type = "bullet"
		muzzle.add_child(projectile)
		projectile.look_at(ray_cast.get_collision_point(), Vector3.UP)
		# Animation
		animation_player.play("shoot")
		yield(animation_player, "animation_finished")
		isShooting = false

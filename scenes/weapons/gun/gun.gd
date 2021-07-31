extends Control

var isShooting = false

onready var animation_player := $AnimationPlayer

const BULLET = preload("res://scenes/weapons/gun/bullet.tscn")

func _on_Player_shoot(weapon, muzzle, ray_cast, _delta):
	# Do nothing if the weapon is not used
	if weapon != name:
		pass
	
	# Shoot
	if !isShooting:
		isShooting = true
		animation_player.play("shoot")
		
		# Bullet
		var bullet = BULLET.instance()
		muzzle.add_child(bullet)
		bullet.look_at(ray_cast.get_collision_point(), Vector3.UP)
		
		yield(animation_player, "animation_finished")
		isShooting = false

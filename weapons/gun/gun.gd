extends Control

var isShooting = false

onready var animation_player := $AnimationPlayer

func _on_Player_shoot(weapon, _delta):
	# Do nothing if the weapon is not used
	if weapon != name:
		pass
	
	# Shoot
	if !isShooting:
		isShooting = true
		animation_player.play("shoot")
		yield(animation_player, "animation_finished")
		isShooting = false

func _on_Player_reload(weapon, _delta):
	# Do nothing if the weapon is not used
	if weapon != name:
		pass

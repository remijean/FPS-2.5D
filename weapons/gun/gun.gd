extends Control

signal ammo_changed(new_ammo)

var current_ammo := MAX_AMMO
var isReloading = false
var isShooting = false

const MAX_AMMO = 10

onready var animation_player := $AnimationPlayer

func _on_Player_shoot(weapon, _delta):
	# Do nothing if the weapon is not used
	if weapon != name:
		pass
	
	# Shoot
	if !isShooting && !isReloading:
		isShooting = true
		var new_ammo = current_ammo
		if current_ammo:
			animation_player.play("shoot")
			new_ammo -= 1
		else:
			animation_player.play("dry")
		yield(animation_player, "animation_finished")
		set_ammo(new_ammo)
		isShooting = false

func _on_Player_reload(weapon, _delta):
	# Do nothing if the weapon is not used
	if weapon != name:
		pass
	
	# Reload
	if !isReloading:
		isShooting = false
		isReloading = true
		animation_player.play("reload")
		yield(animation_player, "animation_finished")
		set_ammo(MAX_AMMO)
		isReloading = false

func set_ammo(new_ammo):
	current_ammo = new_ammo
	emit_signal("ammo_changed", new_ammo)

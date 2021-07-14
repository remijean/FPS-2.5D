extends Control

var walk_blend := 0.0
var ammo := AMMO_MAX
var isReloading = false
var isShooting = false

const AMMO_MAX = 10

onready var animation_player := $AnimationPlayer
onready var animation_tree := $AnimationTree

func _on_Player_shoot(weapon, _delta):
	# Do nothing if the weapon is not used
	if weapon != name:
		pass
	
	# Shoot
	if !isShooting && !isReloading:
		isShooting = true
		# Ammo OK = shoot
		if ammo:
			animation_player.play("shoot")
			ammo = ammo - 1
		# Ammo KO = dry
		else:
			animation_player.play("dry")
		yield(animation_player, "animation_finished")
		isShooting = false
		print_debug(ammo)

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
		ammo = AMMO_MAX
		isReloading = false
		print_debug(ammo)

func _on_Player_state_changed(new_state, delta):
	if new_state == PlayerEnum.WALK:
		set_walk_blend(1, delta)
	else:
		set_walk_blend(0, delta)

func set_walk_blend(to, delta):
	walk_blend = lerp(walk_blend, to, 10 * delta)
	animation_tree.set("parameters/WalkBlend/blend_amount", walk_blend)

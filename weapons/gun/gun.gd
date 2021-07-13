extends Control

var walk_blend := 0.0

onready var animation_player := $AnimationPlayer
onready var animation_tree := $AnimationTree

func _on_Player_shoot(weapon, _delta):
	# Do nothing if the weapon is not used
	if weapon != name:
		pass
	
	# Fire
	if !animation_player.is_playing():
		animation_player.play("shoot")

func _on_Player_state_changed(new_state, delta):
	match new_state:
		PlayerEnum.IDLE:
			set_walk_blend(0, delta)
		PlayerEnum.WALK:
			set_walk_blend(1, delta)

func set_walk_blend(to, delta):
	walk_blend = lerp(walk_blend, to, 10 * delta)
	animation_tree.set("parameters/WalkBlend/blend_amount", walk_blend)

extends Sprite3D

signal state_changed(new_state)

var state := WeaponEnum.IDLE

onready var animation_player := $AnimationPlayer
onready var player := get_owner()
onready var ray_cast := player.get_node("Camera/RayCast")
onready var muzzle := player.get_node("Camera/Muzzle")

const PROJECTILE = preload("res://scenes/projectile/projectile.tscn")

func _ready():
	set_state(WeaponEnum.IDLE)
	
func _on_Player_shoot(weapon):
	# Do nothing if the weapon is not used
	if weapon != name:
		pass
	if state == WeaponEnum.IDLE:
		set_state(WeaponEnum.SHOOT)

func _on_Gun_state_changed(new_state):
	match new_state:
		WeaponEnum.IDLE:
			animation_player.play("idle")
		WeaponEnum.SHOOT:
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
			set_state(WeaponEnum.IDLE)

func set_state(new_state):
	emit_signal("state_changed", new_state)
	state = new_state

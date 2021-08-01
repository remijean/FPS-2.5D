extends KinematicBody

signal state_changed(new_state)

onready var body = $Body

var collider
var state := ProjectileEnum.IDLE
# Values ​​defined in the weapons
var speed := 0.0
var damage := 0
var type := ""

func _ready():
	set_as_toplevel(true)
	set_state(ProjectileEnum.IDLE)

func _process(delta):
	# Movement
	var collide = move_and_collide(-transform.basis.z * speed * delta * 100)
	if collide:
		collider = collide.get_collider()
		set_state(ProjectileEnum.IMPACT)
		
func _on_Body_animation_finished():
	# Destroy
	if "impact" in body.get_animation():
		set_state(ProjectileEnum.DESTROY)

func _on_Projectile_state_changed(new_state):
	match new_state:
		ProjectileEnum.IDLE:
			body.play(type + "_idle")
		ProjectileEnum.IMPACT:
			speed = 0
			body.play(type + "_impact")
			if collider.is_in_group("Enemy"):
				collider.health -= damage
		ProjectileEnum.DESTROY:
			queue_free()

func set_state(new_state):
	emit_signal("state_changed", new_state)
	state = new_state

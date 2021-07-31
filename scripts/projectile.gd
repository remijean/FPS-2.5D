extends KinematicBody

onready var collision_shape = $CollisionShape
onready var body = $Body

var speed := 1
export var damage := 0

func _ready():
	set_as_toplevel(true)

func _process(delta):
	# Movement
	var collide = move_and_collide(-transform.basis.z * speed * delta * 100)
	if collide:
		#var collider = collide.get_collider()
		# Impact
		speed = 0
		body.set_visible(false)
		collision_shape.set_disabled(true)
		# Damage
		#if collider.is_in_group("Enemy"):
			#collider.health -= damage
	
	# Destroy
	if !body.is_visible():
		queue_free()

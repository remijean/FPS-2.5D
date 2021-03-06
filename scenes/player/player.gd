extends KinematicBody

signal state_changed(new_state, delta)
signal shoot(weapon)

const GRAVITY := -15
const MOUSE_SENSITIVITY := 0.005
const SPEED := 10

var walk_blend := 0.0
var health := 100.0
var velocity := Vector3()
var state := PlayerEnum.FALL
var weapon := "Gun"

onready var camera := $Camera
onready var animation_player := $AnimationPlayer
onready var animation_tree := $AnimationTree

func _input(event):
	# Rotation
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg2rad(-90), deg2rad(90))

func _process(_delta):
	# Death
	if health <= 0:
		queue_free()
	
	# Shoot
	if Input.is_action_pressed("shoot"):
		emit_signal("shoot", weapon)

func _physics_process(delta):
	# Direction
	var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	var direction = transform.basis.xform(Vector3(x, 0, z)).normalized() * SPEED
	
	# State
	if is_on_floor() and !direction:
		set_state(PlayerEnum.IDLE, delta)
	elif is_on_floor() and direction:
		set_state(PlayerEnum.WALK, delta)
	else:
		set_state(PlayerEnum.FALL, delta)
	
	# Gravity
	velocity.y += GRAVITY * delta
	var snap = Vector3.DOWN
	
	# Movement
	velocity = move_and_slide_with_snap(Vector3(direction.x, velocity.y, direction.z), snap, Vector3.UP, true)

func _on_Player_state_changed(new_state, delta):
	match new_state:
		PlayerEnum.IDLE:
			animation_player.play("idle")
			set_walk_blend(0, delta)
		PlayerEnum.WALK:
			animation_player.play("walk")
			set_walk_blend(1, delta)
		PlayerEnum.FALL:
			animation_player.stop()
	
func set_state(new_state, delta):
	emit_signal("state_changed", new_state, delta)
	state = new_state

func set_walk_blend(to, delta):
	walk_blend = lerp(walk_blend, to, 10 * delta)
	animation_tree.set("parameters/WalkBlend/blend_amount", walk_blend)

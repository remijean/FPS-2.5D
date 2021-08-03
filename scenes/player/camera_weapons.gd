extends Camera

onready var camera := get_owner().get_node("Camera")

func _process(_delta):
	global_transform = camera.global_transform

extends Control

onready var fire = preload("res://weapons/gun/fire.wav")
onready var animationPlayer = $AnimationPlayer

func _on_Player_shoot(weapon):
	# Ignore if the player is not using this weapon
	if(weapon != name):
		pass
	
	# Fire effect
	if(!animationPlayer.is_playing()):
		# Sound
		var firePlayer := AudioStreamPlayer2D.new()
		firePlayer.set_stream(fire)
		add_child(firePlayer)
		firePlayer.play()
		
		# Animation
		animationPlayer.play("fire")

extends Control

onready var ammo := $Ammo

func _on_Gun_ammo_changed(new_ammo):
	ammo.set_text(String(new_ammo))

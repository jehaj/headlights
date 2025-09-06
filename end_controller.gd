extends Node

@export var sprite3D: Node3D

func _on_timer_timeout():
	sprite3D.visible = true

extends Node3D

@export_range(2.5, 20) var duration = 2.5

var tween: Tween

func _ready() -> void:
	tween = get_tree().create_tween()

	tween.set_loops()
	tween.tween_property(self, "rotation_degrees", Vector3(0, 360, 0), duration)
	tween.tween_property(self, "rotation_degrees", Vector3(0, 0, 0), 0)

func _exit_tree() -> void:
	tween.kill()

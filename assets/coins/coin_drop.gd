extends RigidBody3D

@export var lifetime: float = 5.0

func _ready() -> void:
	
	rotation = Vector3(
		randf_range(0, TAU),  # random yaw
		randf_range(0, TAU),  # random pitch
		randf_range(0, TAU)   # random roll
	)
	
	# Remove after some time
	await get_tree().create_timer(lifetime).timeout
	queue_free()

extends AnimatableBody3D

var direction = 0
@export var min_pos: float = 6.5
@export var max_pos: float = 13.5

@export var speed: float = 5

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	direction = (Input.is_action_pressed("up") as int) - (Input.is_action_pressed("down") as int)
	if (self.position.y < min_pos and direction < 0) or \
	   (self.position.y > max_pos and direction > 0):
		return
	self.position += Vector3.UP * direction * speed * delta

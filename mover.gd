extends Node

var speed
@export var speed_delta: float = 1

func _physics_process(delta: float) -> void:
	var parent = self.get_parent()
	if parent as GameController == null:
		push_error("My parent is Nil (", parent.name,") and I am ", self.name)
	self.speed = (parent as GameController).car_speed
	self.position += Vector3.LEFT * self.speed * delta * speed_delta

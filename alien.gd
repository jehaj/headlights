class_name Alien extends RigidBody3D

@export var ray_cast: RayCast3D
@export var sprite: AnimatedSprite3D
@export var camera3D: Node3D

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var alien_position = self.position
	var direction: Vector3 = alien_position - camera3D.position
	direction = direction.normalized()
	var col: Node3D = self.get_node("Area3D") as Node3D
	col.look_at(direction + alien_position)
	
	if sprite.animation == "hit":
		return
	var animation: String = "stand" if ray_cast.is_colliding() else "jump"
	sprite.animation = animation

func hit() -> void:
	print("Alien collided with something.")
	sprite.play("hit")
	

func _on_animated_sprite_3d_animation_finished() -> void:
	print("Alien's animation finished.")
	if sprite.animation == "hit":
		print("Changing animation back to normal.")
		sprite.animation = "stand"

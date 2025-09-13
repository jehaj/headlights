class_name Alien extends RigidBody3D

@export var ray_cast: RayCast3D
@export var sprite: AnimatedSprite3D
@export var camera3D: Node3D
@export var loss_amount: int = 5

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

signal area_collision(body: Node3D)

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
	audio_player.play()
	lose_coins(loss_amount)

@export var coin_drop_scene: PackedScene

func lose_coins(amount: int) -> void:
	var loss = min(amount, Global.score)
	
	for i in range(loss):
		drop_coin()

func drop_coin() -> void:
	if coin_drop_scene == null:
		return
	
	var coin_instance = coin_drop_scene.instantiate()
	get_parent().add_child(coin_instance)
	
	# Place it slightly above the player
	coin_instance.global_transform.origin = global_transform.origin # + Vector3.UP * 1
	
	coin_instance.angular_velocity = Vector3(
		randf_range(-5, 5),
		randf_range(-5, 5),
		randf_range(-5, 5)
	)
	
	# Add random impulse so coins fly out
	var random_dir = Vector3(
		randf_range(-1, 1),
		randf_range(0.5, 1),
		0
	).normalized()
	
	var impulse_strength = randf_range(2, 4)
	coin_instance.apply_impulse(random_dir * impulse_strength)

func _on_animated_sprite_3d_animation_finished() -> void:
	print("Alien's animation finished.")
	if sprite.animation == "hit":
		print("Changing animation back to normal.")
		sprite.animation = "stand"


func _on_area_3d_body_entered(body: Node3D) -> void:
	area_collision.emit(body)

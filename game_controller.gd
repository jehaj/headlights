class_name GameController extends Node

@export var car_speed: float = 5
@export var max_car_speed: float = 5
@export var alien: Alien

var second_scene: PackedScene
var third_scene: PackedScene

func _ready() -> void:
	var children = get_children()
	for child in children:
		var child_node = child as Node3D
		if child_node.name.contains("MovingTree") or \
		   child_node.name.contains("MovingRock"):
			var random_rotation = randf() * 2 * PI
			child_node.rotation = Vector3(0, random_rotation, 0)
	second_scene = load("res://second.tscn")
	third_scene = load("res://third.tscn")

func _process(delta: float) -> void:
	self.car_speed = self.car_speed + 2 * delta
	self.car_speed = clampf(self.car_speed, 0, max_car_speed)

func _on_alien_body_entered(body: Node3D) -> void:
	print("You hit something!")

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Obstacle"):
		print("You hit an obstacle!")
		alien.hit()
		self.car_speed -= 10
	elif body.is_in_group("Coin"):
		body.get_node("../..").queue_free()
		(get_tree().root.get_child(1).get_node("ScoreController") as SceneController).increase_score()

func _on_audio_stream_player_finished() -> void:
	print("Switching scene. Who am I: ", self.name)
	print("Am I in a tree? ", is_inside_tree())
	if get_tree().current_scene.name == "first":
		get_tree().change_scene_to_packed(second_scene)
	elif get_tree().current_scene.name == "second":
		get_tree().change_scene_to_packed(third_scene)

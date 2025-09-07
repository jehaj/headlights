class_name SceneController extends Node3D

@onready var hunner = $Hunner
@onready var tenner = $Tenner
@onready var oner = $Oner

func load_numbers() -> Array[Node]:
	var numbers: Array[Node] = []
	for i in range(10):
		var number = load("res://assets/coins/number-double-%d.glb" % i)
		var node: Node3D = number.instantiate()
		node.rotation = Vector3(0, 1, 0)
		(node as Node3D).visible = false
		numbers.append(node)
	return numbers

func _ready() -> void:
	var numbers = load_numbers()
	add_digit(hunner, numbers, Global.score / 100 % 10, true)
	add_digit(tenner, numbers, Global.score / 10 % 10, true)
	add_digit(oner, numbers, Global.score % 10, false)

func add_digit(parent: Node, numbers: Array, digit: int, duplicate: bool = true) -> void:
	for i in range(numbers.size()):
		var node: Node3D = numbers[i].duplicate() if duplicate else numbers[i]
		node.visible = (i == digit)
		parent.add_child(node)

func increase_score():
	increase_system(oner, 1)
	increase_system(tenner, 10)
	increase_system(hunner, 100)
	Global.score += 1
	print("You got a point! Score is now %d" % Global.score)

func increase_system(p: Node3D, m: int):
	var next_score = Global.score + 1
	var score_idx = Global.score / m % 10
	var next_score_idx = next_score / m % 10
	if score_idx == next_score_idx:
		return
	var node = p.get_child(score_idx)
	var next_node = p.get_child(next_score_idx)
	
	var off_rotation = -1.2
	var animation_duration = 0.3
	var tween = get_tree().create_tween()
	tween.tween_property(node, "rotation:y", off_rotation, animation_duration)
	tween.tween_property(node, "visible", false, 0)
	
	tween.tween_property(next_node, "rotation:y", -off_rotation*2, 0)
	tween.tween_property(next_node, "visible", true, 0)
	tween.tween_property(next_node, "rotation:y", 1, animation_duration)

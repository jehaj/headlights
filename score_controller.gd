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
	@warning_ignore("integer_division")
	add_digit(hunner, numbers, Global.score / 100 % 10, true)
	@warning_ignore("integer_division")
	add_digit(tenner, numbers, Global.score / 10 % 10, true)
	add_digit(oner, numbers, Global.score % 10, false)

func add_digit(parent: Node, numbers: Array, digit: int, duplicated: bool = true) -> void:
	for i in range(numbers.size()):
		var node: Node3D = numbers[i].duplicate() if duplicated else numbers[i]
		node.visible = (i == digit)
		parent.add_child(node)

func increase_score():
	update_score(1)

func update_score(amount: int):
	if amount < 0:
		amount = max(amount, -Global.score)
	increase_system(amount, oner, 1)
	increase_system(amount, tenner, 10)
	increase_system(amount, hunner, 100)
	Global.score += amount
	print("You got ", amount, " points! Score is now %d" % Global.score)

func increase_system(amount: int, p: Node3D, m: int):
	var next_score = Global.score + amount
	@warning_ignore("integer_division")
	var score_idx = Global.score / m % 10
	@warning_ignore("integer_division")
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

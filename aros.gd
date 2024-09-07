extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var greyscale = self.get_material()
	await get_tree().create_timer(6).timeout
	self.set_material(null)
	await get_tree().create_timer(7).timeout
	self.set_material(greyscale)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

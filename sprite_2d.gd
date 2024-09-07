extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Vector to store movement direction
	var direction = Vector2.ZERO
	var start_y=direction.y
	# Check for input and set direction
	var pos = 0
	print(self.get_material())
	while(1):
		while(pos<=700):
			direction = Vector2.ZERO
			direction.y += 1
			pos+=1
			direction = direction.normalized()
			position += direction
			await get_tree().create_timer(0.005).timeout
		await get_tree().create_timer(2).timeout
		while(pos>=0):
			direction = Vector2.ZERO
			direction.y -= 1
			pos-=1
			direction = direction.normalized()
			position += direction
			await get_tree().create_timer(0.005).timeout


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

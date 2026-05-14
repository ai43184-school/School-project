extends ColorRect
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = GameManager.player_pos.x - 5000
	position.y -= 3

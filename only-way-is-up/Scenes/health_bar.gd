extends ProgressBar


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_health()

func update_health():
	if GameManager.playerdamage:
		value -= 1
		GameManager.health -= GameManager.damage
		print("Player took damage!")

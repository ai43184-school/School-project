extends CanvasLayer

@onready var healthbar: ProgressBar = $BoxContainer/ProgressBar

func update_health():
	if GameManager.can_be_hit == true:
			GameManager.can_be_hit = false
			GameManager.hitCooldown.start()
			healthbar.value -= 1
			GameManager.health -= GameManager.damage
			print("Player took damage!")
		


func _on_game_manager_playerdamage() -> void:
	print("Player took damage!")
	update_health()

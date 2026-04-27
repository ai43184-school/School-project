extends CanvasLayer

@onready var healthbar: ProgressBar = $BoxContainer/ProgressBar

func _process(delta: float) -> void:
	healthbar.value = GameManager.health

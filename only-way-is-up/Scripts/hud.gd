extends CanvasLayer

@onready var healthbar: ProgressBar = $BoxContainer/ProgressBar
@onready var score: Label = $ScoreContainer/Score

func _process(delta: float) -> void:
	healthbar.value = GameManager.health
	score.text = "Score:" + str(GameManager.score)

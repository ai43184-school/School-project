extends Area2D

@export var death_timer: Timer
@export var particles: CPUParticles2D
@export var sprite: Sprite2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		death_timer.start()
		GameManager.enemydeath.emit(1)
		GameManager.can_launch = true
		sprite.visible = false
		particles.restart()
		particles.visible = true


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		queue_free()


func _on_death_timer_timeout() -> void:
	queue_free()

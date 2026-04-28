extends Area2D

@export var death_timer: Timer
@export var particles: CPUParticles2D
@export var sprite: AnimatedSprite2D
var enemy_type

var enemies = ["enemy", "enemy", "enemy", "spike"]

func _ready() -> void:
	enemy_type = enemies.pick_random()
	if enemy_type == "enemy":
		sprite.animation = "default"
	if enemy_type == "spike":
		sprite.animation = "Spike"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if enemy_type == "enemy":
			death_timer.start()
			$CollisionShape2D.queue_free()
			GameManager.enemydeath.emit(1)
			GameManager.can_launch = true
			sprite.visible = false
			particles.restart()
			particles.visible = true
			GameManager.score += 100
		
		if enemy_type == "spike":
			death_timer.start()
			$CollisionShape2D.queue_free()
			GameManager.playerdamage.emit()
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

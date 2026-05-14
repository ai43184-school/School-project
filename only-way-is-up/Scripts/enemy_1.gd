extends Area2D

@export var death_timer: Timer
@export var particles: CPUParticles2D
@export var sprite: AnimatedSprite2D
@export var explosionsound: AudioStreamPlayer2D
var enemy_type

var chance = ["live", "die"]
var enemies = ["enemy", "enemy", "enemy", "enemy", "enemy", "enemy", "enemy", "enemy", "enemy", "enemy", "enemy", "enemy", "enemy", "enemy", "enemy", "enemy", "enemy", "enemy", "enemy", "enemy", "spike", "spike", "heal"]

func _ready() -> void:
	enemy_type = enemies.pick_random()
	var can_live = chance.pick_random()
	if enemy_type == "enemy":
		sprite.animation = "default"
	if enemy_type == "spike":
		sprite.animation = "Spike"
	if enemy_type == "heal":
		sprite.animation = "Heal"
	
	if can_live == "live":
		pass
	elif can_live == "die":
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if enemy_type == "enemy":
			explosionsound.play()
			death_timer.start()
			$CollisionShape2D.queue_free()
			GameManager.enemydeath.emit(1)
			GameManager.can_launch = true
			sprite.visible = false
			particles.restart()
			particles.visible = true
			GameManager.score += 100
			
		if enemy_type == "heal":
			explosionsound.play()
			death_timer.start()
			$CollisionShape2D.queue_free()
			GameManager.playerheal.emit()
			GameManager.enemydeath.emit(1)
			GameManager.can_launch = true
			sprite.visible = false
			particles.restart()
			particles.visible = true
			GameManager.score += 100
		
		if enemy_type == "spike":
			explosionsound.play()
			death_timer.start()
			$CollisionShape2D.queue_free()
			GameManager.damage = 1
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

extends Node

#enemies
signal enemydeath

#player movement
var can_launch = true

#health
@onready var hitCooldown: Timer = $HitTimer

signal playerdamage

var health: int = 3
var damage: int = 1
var heal: int = 1
var can_be_hit = true
var took_damage = false

#Scoring
var score: int = 0

#func _process(delta: float) -> void:
	#print(health)

func update_health():
	if can_be_hit == true:
			can_be_hit = false
			hitCooldown.start()
			health -= damage
			print("Player took damage!")
			

func _on_hit_timer_timeout() -> void:
	can_be_hit = true
	took_damage = false


func _on_playerdamage() -> void:
	print("Player took damage!")
	took_damage = true
	update_health()

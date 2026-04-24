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

#func _process(delta: float) -> void:
	#print(health)


func _on_hit_timer_timeout() -> void:
	can_be_hit = true

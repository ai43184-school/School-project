extends Node

#enemies
signal enemydeath

#player movement
var can_launch = true

#health
signal playerdamage

var health: int = 3
var damage: int = 1
var heal: int = 1

#func _process(delta: float) -> void:
	#print(health)

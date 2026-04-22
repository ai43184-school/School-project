extends Node

#enemies
signal enemydeath

#player movement
var can_launch = true

#health
var health: int = 3
var damage: int = 1
var heal: int = 1


func take_damage():
	health -= damage

func give_heal():
	health += heal

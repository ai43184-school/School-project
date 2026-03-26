extends Node

#enemies
signal enemydeath

#player movement
var can_launch = true

#map generation
var enemyspawn = FastNoiseLite.new()

var width = 64
var height = 64

@onready var player = get_parent().current_scene().get_node("Player")

var loaded_chunks = []

func _ready():
	enemyspawn.seed = randi()
	
	enemyspawn.frequency = 0.5


func process():
	var player_pos = player.position


func generate_chunk(pos):
	for x in range(width):
		for y in range(height):
			
			var spawn = enemyspawn.get_noise_2d(pos.x - (width / 2) + x,pos.y - (height / 2) + y) * 10

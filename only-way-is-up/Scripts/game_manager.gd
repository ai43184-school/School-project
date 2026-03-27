extends Node

#enemies
@warning_ignore("unused_signal")
signal enemydeath

#player movement
var can_launch = true

# Preload the enemy scene
var enemy_scene = preload("res://Scenes/Enemy1.tscn")

# Set a seed for reproducibility
@export var spawn_seed = randi_range(0,5000)
var rng = RandomNumberGenerator.new()

func _ready():
	# Seed the RNG
	rng.seed = spawn_seed
	spawn_enemies(1000) # Spawn 10 enemies

func spawn_enemies(amount):
	for i in range(amount):
		var enemy = enemy_scene.instantiate()
		
		# Generate random position within a specific area
		var spawn_x = rng.randf_range(0, 1000)
		var spawn_y = rng.randf_range(0, 600)
		enemy.position = Vector2(spawn_x, spawn_y)
		
		# Add enemy to the scene
		add_child(enemy)
		

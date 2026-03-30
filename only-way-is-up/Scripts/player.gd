extends RigidBody2D

@export var camera_2d: Camera2D

var velocity : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO
var speed: float = 2

# spawning enemies
@onready var enemy_scene = preload("res://Scenes/Enemy1.tscn")

var enemies = ["normalEnemy", "spikeEnemy"] # Note: Not currently used in your spawn logic

var distance: float = 0.0
var distance_used: float = 0.0
var spawn_interval: float = 50.0 # Adjust this for how often enemies spawn

func spawn_enemy():
	var enemy_to_spawn = select_enemy_to_spawn()
	
	# Your custom random Y calculation
	var x_pos: float = floor(abs(randf_range(0.0, -50.0) - randf_range(0.0, 50.0)) * (100 - (-2)) + (-2))
	var pos_to_spawn_enemy: Vector2 = Vector2(x_pos, distance)
	
	enemy_to_spawn.position = pos_to_spawn_enemy
	print("Spawning enemy at: ", pos_to_spawn_enemy)
	
	# Using get_parent().add_child() is often safer than add_sibling() 
	# to avoid issues with the scene tree order.
	get_parent().add_child(enemy_to_spawn)

func select_enemy_to_spawn():
	# This takes the PackedScene and creates an actual node instance
	var new_enemy = enemy_scene.instantiate()
	return new_enemy


func Launch():
	direction = (get_global_mouse_position() - position)
	if Input.is_action_pressed("Launch"):
		Engine.time_scale = 0.25
		look_at(get_global_mouse_position())
	elif Input.is_action_just_released("Launch"):
		linear_velocity = velocity
		apply_impulse(direction * speed)
		Engine.time_scale = 1
		GameManager.can_launch = true
	else:
		Engine.time_scale = 1

func _process(delta):
	if GameManager.can_launch:
		Launch()
	
	# 1. Update the 'distance' based on player progress
	if (distance < position.y + 50):
		distance = position.y - 500
	
	# 2. Logic to trigger a spawn every 'spawn_interval' units
	if (distance - distance_used > spawn_interval):
		distance_used = distance
		spawn_enemy()

func _on_area_2d_body_entered(body: Node2D) -> void:
	GameManager.can_launch = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		linear_velocity = -linear_velocity / 4
		linear_velocity += Vector2.UP*500

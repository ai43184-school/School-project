extends RigidBody2D

@export var camera_2d: Camera2D

var velocity : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO
var speed: float = 2

# spawning enemies
@onready var enemy = preload("res://Scenes/Enemy1.tscn")

var enemies = ["normalEnemy", "spikeEnemy"]

var distance: float
var distanceUsed: float


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

func _physics_process(delta: float) -> void:
	if GameManager.can_launch:
		Launch()
	
	
	if (distance < position.x + 50):
		distance = position.x + 50
	
	var distToGo: float = floor(distance - distanceUsed)
	
	if (distanceUsed < distance && distToGo > 4):
		distanceUsed = distance
		SpawnEnemy()
	
	
	

func SpawnEnemy():
	var enemyToSpawn = SelectEnemyToSpawn()
	
	var yPos: float = floor(abs(randf_range(0.0,1.0)-randf_range(0.0,1.0)) * (1+100 - (-2)) + (-2))
	var posToSpawnEnemy: Vector2 = Vector2(distance,yPos)
	
	enemyToSpawn.position = posToSpawnEnemy
	print(posToSpawnEnemy)
	add_sibling(enemyToSpawn)

func SelectEnemyToSpawn():
	var enemy_scene = enemy.instantiate()
	return enemy_scene

func _on_area_2d_body_entered(body: Node2D) -> void:
	GameManager.can_launch = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		linear_velocity = -linear_velocity / 4
		linear_velocity += Vector2.UP*500

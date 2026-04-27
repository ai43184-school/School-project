extends RigidBody2D

@export var camera_2d: Camera2D
@export var trajectory_line: Line2D
@export var hitbox: CollisionObject2D
@export var environment: WorldEnvironment

var velocity : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO
var speed: float = 1.7098642185873
var start_line_pos
var end_line_pos

# spawning enemies
@onready var enemy_scene = preload("res://Scenes/Enemy1.tscn")

var enemies = ["normalEnemy", "spikeEnemy"] 

var distance: float = 0.0
var distance_used: float = 0.0
var spawn_interval: float = 100.0



func _ready():
	trajectory_line.width = 10.0

func spawn_enemy():
	var enemy_to_spawn = select_enemy_to_spawn()
	
	var x_pos: float = floor(abs(randf_range(0.0, -400.0) - randf_range(0.0, 400.0)) * (100 - (-2)) + (-2))
	var pos_to_spawn_enemy: Vector2 = Vector2(x_pos, distance)
	
	enemy_to_spawn.position = pos_to_spawn_enemy
	#print("Spawning enemy at: ", pos_to_spawn_enemy)
	
	get_parent().add_child(enemy_to_spawn)

func select_enemy_to_spawn():
	var new_enemy = enemy_scene.instantiate()
	return new_enemy


func Launch():
	direction = (get_global_mouse_position() - position)
	if Input.is_action_pressed("Launch"):
		Engine.time_scale = 0.25
		environment.environment.adjustment_saturation = lerp(environment.environment.adjustment_saturation, 0.5, 0.1)
		trajectory_line.add_point(start_line_pos)
		trajectory_line.add_point(end_line_pos)
	elif Input.is_action_just_released("Launch"):
		linear_velocity = velocity
		apply_impulse(direction * speed)
		Engine.time_scale = 1
		GameManager.can_launch = false
	else:
		environment.environment.adjustment_saturation = lerp(environment.environment.adjustment_saturation, 1.0, 0.1)
		Engine.time_scale = 1
		

func _process(delta):
	if GameManager.health == 0:
		queue_free()
	
	start_line_pos = to_local(position)
	end_line_pos = get_local_mouse_position()
	if get_local_mouse_position():
		trajectory_line.clear_points()
	
	if GameManager.can_launch:
		Launch()
	
	if (distance < position.y - 30):
		distance = position.y - 800

	if (distance - distance_used < spawn_interval):
		distance_used = distance
		spawn_enemy()

func _on_area_2d_body_entered(body: Node2D) -> void:
	GameManager.can_launch = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		linear_velocity.x = linear_velocity.x
		linear_velocity.y = linear_velocity.y - 500

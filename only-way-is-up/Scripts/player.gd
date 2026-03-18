extends RigidBody2D

var velocity : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO
var speed: float = 2


func Launch():
	direction = (get_global_mouse_position() - position)
	if Input.is_action_pressed("Launch"):
		Engine.time_scale = 0.25
		look_at(get_global_mouse_position())
	elif Input.is_action_just_released("Launch"):
		linear_velocity = velocity
		apply_impulse(direction * speed)
		Engine.time_scale = 1
		GameManager.can_launch = false
	else:
		Engine.time_scale = 1

func _physics_process(delta: float) -> void:
	if GameManager.can_launch:
		Launch()


func _on_area_2d_body_entered(body: Node2D) -> void:
	GameManager.can_launch = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		linear_velocity += Vector2.UP*1200

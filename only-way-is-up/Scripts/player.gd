extends RigidBody2D

var velocity : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO
var speed: float = 2
var can_launch = true


func Launch():
	direction = (get_global_mouse_position() - position)
	if Input.is_action_pressed("Launch"):
		Engine.time_scale = 0.25
		look_at(get_global_mouse_position())
	elif Input.is_action_just_released("Launch"):
		linear_velocity = velocity
		apply_impulse(direction * speed)
		can_launch = false
		Engine.time_scale = 1
	else:
		Engine.time_scale = 1

func KilledEnemy():
	if GameManager.enemydeath:
		apply_impulse(Vector2.UP)


func _physics_process(delta: float) -> void:
	if can_launch:
		Launch()


func _on_area_2d_body_entered(body: Node2D) -> void:
	can_launch = true

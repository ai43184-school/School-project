extends RigidBody2D

var velocity : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO
var speed: float = 1200.0


func _physics_process(delta: float) -> void:
	direction = (get_global_mouse_position() - position)
	if Input.is_action_pressed("Launch"):
		velocity = direction * speed

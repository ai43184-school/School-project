extends RigidBody2D

const speed = 10

func Launch():
	var mouse_pos = get_viewport().get_mouse_position()
	

func _physics_process(delta: float) -> void:
	Launch()

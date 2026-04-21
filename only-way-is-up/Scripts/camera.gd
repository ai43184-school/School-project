extends Camera2D

@export var player: RigidBody2D

var velocity: Vector2
var speed
var max_speed: float = 1000.0
var defaultZoom: float = 1.0
var maxZoom: float = 0.3
var zoom_speed = 5.0


func _process(delta: float) -> void:
	velocity = player.linear_velocity
	speed = velocity.length()
	var target_zoom_val = remap(speed, 0, max_speed, defaultZoom, maxZoom)
	
	target_zoom_val = clamp(target_zoom_val, maxZoom, defaultZoom)
	
	var target_zoom_vec = Vector2(target_zoom_val, target_zoom_val)
	zoom = zoom.lerp(target_zoom_vec, zoom_speed * delta)
	
	print(velocity)

extends Camera2D

#Camera Movement
@export var player: RigidBody2D

var velocity: Vector2
var speed
var max_speed: float = 1000.0
var defaultZoom: float = 1.0
var maxZoom: float = 0.3
var zoom_speed = 5.0

#Camera Shake
@export var randomStrength: float = 30.0
@export var shakeFade: float = 5.0

var rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0

func apply_shake():
	shake_strength = randomStrength

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength),rng.randf_range(-shake_strength, shake_strength))

func camShake(time):
	apply_shake()
	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength,0,shakeFade * time)
		
		offset = randomOffset()

func _process(delta: float) -> void:
	if GameManager.took_damage:
		camShake(delta)
	
	velocity = player.linear_velocity
	speed = velocity.length()
	var target_zoom_val = remap(speed, 0, max_speed, defaultZoom, maxZoom)
	
	target_zoom_val = clamp(target_zoom_val, maxZoom, defaultZoom)
	
	var target_zoom_vec = Vector2(target_zoom_val, target_zoom_val)
	zoom = zoom.lerp(target_zoom_vec, zoom_speed * delta)
	
	print(velocity)

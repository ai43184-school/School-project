extends Camera2D

@export var player: RigidBody2D

var speed: float = 0.1
var velSpeed: Vector2

var defaultZoom: float = 7
var zoomSpeed: float = 0.2
var velZoom: float

var hieght: float = 0

var yMin: float = 0

var instance: Node

func _ready():
	instance = self

func _process(delta):
	position = Vector2((lerp(position, player.position, velSpeed)))
	
	var desiredZoom: float = defaultZoom + position.distance_to(player.position)
	if (desiredZoom > 18):
		desiredZoom = 18
	
	

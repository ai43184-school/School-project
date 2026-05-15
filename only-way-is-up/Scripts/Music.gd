extends AudioStreamPlayer2D

var tween = create_tween()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playing = true


func _process(delta: float) -> void:
	if GameManager.score == 0:
		stream.set_sync_stream_volume(0, 0)
		stream.set_sync_stream_volume(1, -60)
		stream.set_sync_stream_volume(2, -60)
		stream.set_sync_stream_volume(3, -60)
		stream.set_sync_stream_volume(4, -60)
	if GameManager.score == 1000:
		stream.set_sync_stream_volume(0, -60)
		stream.get_sync_stream_volume(1, 0)
		stream.set_sync_stream_volume(2, -60)
		stream.set_sync_stream_volume(3, -60)
		stream.set_sync_stream_volume(4, -60)
	if GameManager.score == 5000:
		stream.set_sync_stream_volume(0, -60)
		stream.set_sync_stream_volume(1, -60)
		stream.set_sync_stream_volume(2, 0)
		stream.set_sync_stream_volume(3, -60)
		stream.set_sync_stream_volume(4, -60)
	if GameManager.score == 10000:
		stream.set_sync_stream_volume(0, -60)
		stream.set_sync_stream_volume(1, -60)
		stream.set_sync_stream_volume(2, -60)
		stream.set_sync_stream_volume(3, 0)
		stream.set_sync_stream_volume(4, -60)
	if GameManager.score == 50000:
		stream.set_sync_stream_volume(0, -60)
		stream.set_sync_stream_volume(1, -60)
		stream.set_sync_stream_volume(2, -60)
		stream.set_sync_stream_volume(3, -60)
		stream.set_sync_stream_volume(4, 0)

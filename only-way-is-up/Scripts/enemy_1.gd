extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GameManager.enemydeath.emit()
		queue_free()

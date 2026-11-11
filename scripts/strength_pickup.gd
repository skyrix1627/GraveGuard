extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.player_strength += 15
	print(Global.player_strength)
	queue_free()

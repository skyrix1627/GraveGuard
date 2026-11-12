extends Area2D
@onready var player = get_tree().get_first_node_in_group("Player")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player.increase_player_range()
	print("idk man somethin")
	queue_free()

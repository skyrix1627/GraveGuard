extends Node2D

@export var enemy_prefab : PackedScene

func _on_timer_timeout() -> void:
	print("im timening")
	var enemy = enemy_prefab.instantiate()
	get_tree().current_scene.add_child(enemy)
	enemy.global_position = global_position

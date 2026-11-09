extends Node2D

@export var enemy_prefab : PackedScene

func _on_timer_2_timeout() -> void:
	print("im timing")
	var enemy = enemy_prefab.instantiate()
	add_child(enemy)

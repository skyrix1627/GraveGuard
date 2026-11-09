extends Node2D

@export var enemy_prefab : PackedScene
@export var target : Node2D

func _on_timer_timeout() -> void:
	print("oh my god im timeing!!!")
	#enemy spawning
	var enemy = enemy_prefab.instantiate()
	enemy.player = target
	get_tree().current_scene.add_child(enemy)
	enemy.global_position = global_position

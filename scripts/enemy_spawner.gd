extends Node2D

@export var enemy_prefab : PackedScene

@onready var timer = $Timer
@onready var spawn_markers = [
	get_tree().current_scene.get_node("arena_zone/TopLeft (Enemy spawn)"),
	get_tree().current_scene.get_node("arena_zone/TopRight (Enemy spawn)"),
	get_tree().current_scene.get_node("arena_zone/BottomLeft (Enemy spawn)"),
	get_tree().current_scene.get_node("arena_zone/BottomRight (Enemy spawn)")
]

var enemies_spawned = 0


func start_wave():
	enemies_spawned = 0
	timer.start()

func _on_timer_timeout() -> void:
	if enemies_spawned < Global.wave:
		var enemy = enemy_prefab.instantiate()
		get_tree().current_scene.add_child(enemy)
		
		var marker = spawn_markers.pick_random()
		enemy.global_position = marker.global_position
		
		enemies_spawned += 1
	if enemies_spawned >= Global.wave:
		print("stop spawning")
		timer.stop()
		
func next_wave():
	Global.wave += 1
	start_wave()
	
func _on_start_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		next_wave()
		print("player entered, start wave")

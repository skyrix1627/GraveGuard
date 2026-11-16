extends Area2D

@export var enemy_prefab : PackedScene

@onready var grave: Area2D = $"."

func _ready():
	add_to_group("enemies")
	var spawner = get_node("/root/Game/enemy_spawner/start_zone")
	spawner.body_entered.connect(_on_start_zone_entered)

func start_wave():
	var enemy = enemy_prefab.instantiate()
	get_tree().current_scene.add_child(enemy)
	enemy.global_position = global_position
		
func next_wave():
	start_wave()
	

func _on_start_zone_entered(body: Node2D) -> void:
	if body.name == "Player":
		next_wave()
		print("player entered, start wave")

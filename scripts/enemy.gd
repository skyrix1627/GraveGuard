extends CharacterBody2D

#const SPEED = 100.0
#var player : Node2D
#
#func _physics_process(delta: float) -> void:
	#var direction = (player.global_position - global_position).normalized()
	#velocity = direction * SPEED
	#move_and_slide()



var SPEED = 100.0

var player : Node2D

func _physics_process(delta: float) -> void:
	if player:
		_attack(delta)

func _attack(delta: float) -> void:
	var direction = (player.position - position).normalized()
	position += direction * SPEED * delta

func _on_sight_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		print(player)


func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	pass # Replace with function body.

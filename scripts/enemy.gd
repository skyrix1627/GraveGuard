extends CharacterBody2D


var SPEED = 100.0

var target = null

func _physics_process(delta: float) -> void:
	if target:
		_attack(delta)

func _attack(delta: float) -> void:
	var direction = (target.position - position).normalized()
	position += direction * SPEED * delta

func _on_sight_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		target = body
		print(target)


func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	pass # Replace with function body.

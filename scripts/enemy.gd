extends CharacterBody2D


const  SPEED: int = 100.0
const 	KNOCKBACK_FORCE: int = 50

var health: int = 100
var target = null

func _physics_process(delta: float) -> void:
	if target:
		_attack(delta)

func _attack(delta: float) -> void:
	var direction = (target.position - position).normalized()
	position += direction * SPEED * delta
	
func take_damage(damage: int, attacker_position: Vector2) -> void:
	health -= damage
	print(health)
	if health <= 0:
		_die()
	else:
		var knockback_direction = (position - attacker_position).normalized()
		var target_position = position + knockback_direction * KNOCKBACK_FORCE
		
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "position", target_position, 0.5)

func _die() -> void:
	queue_free()

func _on_sight_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		target = body
		print(target)


func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	pass # Replace with function body.

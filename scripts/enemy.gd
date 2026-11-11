extends CharacterBody2D

@export var pickUp_prefab : PackedScene
@export var strengthUp_prefab : PackedScene
@export var rangeUp_prefab : PackedScene

const 	KNOCKBACK_FORCE: int = 50

var health: int = 100
var target = null

func _physics_process(delta: float) -> void:
	if target:
		_attack(delta)

func _attack(delta: float) -> void:
	var direction = (target.position - position).normalized()
	position += direction * Global.enemy_speed * delta
	
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
	loot_drop_calc()
	Global.kills += 1
	Global.euro += 1 * Global.wave_multiplier
	
func loot_drop_calc():
	var drop_chance = randf()
	
	if drop_chance <= 0.01: #curently = to 5%
		var strengthUp = strengthUp_prefab.instantiate()
		get_tree().current_scene.add_child(strengthUp)
		strengthUp.global_position = global_position
	elif drop_chance <= 0.10: #curently = to 10% (15% total)
		var pickUp = pickUp_prefab.instantiate()
		get_tree().current_scene.add_child(pickUp)
		pickUp.global_position = global_position
	elif drop_chance <= 0.10: #curently = to 10% (25% total)
		var rangeUp = rangeUp_prefab.instantiate()
		get_tree().current_scene.add_child(rangeUp)
		rangeUp.global_position = global_position
	elif drop_chance <= 0.79:
		print("generic coin or somethin")


func _on_sight_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		target = body
		print(target)

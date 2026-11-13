extends CharacterBody2D

var last_direction: Vector2 = Vector2.RIGHT
var is_attacking: bool = false
var hitbox_offset: Vector2


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_box_baton: Area2D = $hitBoxBaton
@onready var actionable_finder: Area2D = $Direction/ActionableFinder
@onready var attack_range = $hitBoxBaton/CollisionShape2D
 

func _ready() -> void:
	hitbox_offset = hit_box_baton.position

func _physics_process(_delta: float) -> void:
	if GameData.in_dialogue:
		velocity = Vector2.ZERO
		play_animation("idle", last_direction)
		move_and_slide()
		return
		
	hit_box_baton.monitoring = false
	
	if Input.is_action_just_pressed("attack") and not is_attacking:
		attack()
	
	process_movement()
	process_animation()
	move_and_slide()
	
func process_movement() -> void:
	
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direction != Vector2.ZERO:
		velocity = direction * Global.player_speed
		last_direction = direction
		update_hitbox_offset()
	else:
		velocity = Vector2.ZERO
	
	velocity = direction * Global.player_speed
	
func _unhandled_input(event: InputEvent) -> void:
	if GameData.in_dialogue:
		return
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return
	
func process_animation() -> void:
	if is_attacking == true:
		return
	if velocity != Vector2.ZERO:
		play_animation("walk", last_direction)
	else:
		play_animation("idle", last_direction)

func play_animation(prefix: String, dir: Vector2) -> void:
	if dir.x != 0:
		animated_sprite_2d.flip_h = dir.x < 0
		animated_sprite_2d.play(prefix + "_right")
	elif dir.y > 0:
		animated_sprite_2d.play(prefix + "_down")
	elif dir.y < 0:
		animated_sprite_2d.play(prefix + "_up")


func attack() -> void:
	is_attacking = true
	hit_box_baton.monitoring = true
	play_animation("attack", last_direction)
	print("attack")


func _on_animated_sprite_2d_animation_finished() -> void:
	if is_attacking:
		is_attacking = false 


func increase_player_range():

	attack_range.shape.radius *= 1.5
	attack_range.shape.height *= 1.5

func reset_range(): #use on death of player
	attack_range.shape.radius = 8
	attack_range.shape.height = 26


func update_hitbox_offset() -> void:
	var x := hitbox_offset.x
	var y := hitbox_offset.y
	
	match last_direction:
		Vector2.LEFT:
			hit_box_baton.position = Vector2(-x, y)
		Vector2.RIGHT:
			hit_box_baton.position = Vector2(x, y)
		Vector2.UP:
			hit_box_baton.position = Vector2(y, -x)
		Vector2.DOWN:
			hit_box_baton.position = Vector2(-y, x)
			
func _on_hit_box_baton_body_entered(body: Node2D) -> void:
	if is_attacking and body.name.begins_with("Enemy"):
		body.take_damage(Global.player_strength, position)
		

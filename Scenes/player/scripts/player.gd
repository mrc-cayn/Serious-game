extends CharacterBody2D

class_name player

@export var max_health := 3
var health := 3
var moving : bool
var spinning : bool
var can_move : bool = true
var is_falling : bool = false
var direction : Vector2

@export var hammer_impact_time := 0.2
@export var hammer_spin_time_multiplier := 2.0
@export var hammer_enemy_knockback_multiplier := 1.2
var hammer_hit_strengh := 1.0

func _process(delta: float) -> void:
	direction = position.direction_to(
		get_global_mouse_position()).normalized()
	#print(direction)

func _physics_process(delta: float) -> void:
	if velocity.y > 0 :
		is_falling = true
	else :
		is_falling = false
	pass


func _on_animation_hammer_hit() -> void:
	pass # Replace with function body.

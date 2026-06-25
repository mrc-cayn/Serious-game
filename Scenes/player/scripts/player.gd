extends CharacterBody2D

class_name player


@export var max_health := 10
var health := 10
var moving : bool
var can_move : bool = true
var is_falling : bool = false


var spinning : bool
var direction : Vector2

@export var hammer_impact_time := 0.2
@export var hammer_spin_time_multiplier := 1.2
@export var hammer_enemy_knockback_multiplier := 1.2

var hammer_hit_strengh := 1.0


func _ready() -> void:
	health = max_health
	pass

func _process(delta: float) -> void:
	health = max(0,health)
	health = min(health,max_health)
	
	if health == 0:
		G.death = true
		health = max_health
	
	health = max(0,health)
	##print(hammer_hit_strengh)
	#print(moving)
	direction = position.direction_to(
		get_global_mouse_position()).normalized()
	#print(direction)

func _physics_process(delta: float) -> void:
	if velocity.y > 0 :
		is_falling = true
	else :
		is_falling = false
	
	if spinning:
		moving = false
	if velocity == Vector2.ZERO:
		moving = false
	pass


func _on_animation_hammer_hit() -> void:
	if health > 0 :
		health += 1
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	pass # Replace with function body.

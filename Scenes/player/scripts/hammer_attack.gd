extends Node

class_name player_attack

@onready var hammer: Sprite2D = %Hammer
@onready var damage_area: Area2D = $"../Animation/Path2D/PathFollow2D/Damage_area"
@onready var damage_hitbox: CollisionShape2D = $"../Animation/Path2D/PathFollow2D/Damage_area/Damage_hitbox"

@export var _player : player
@export var max_thrust_speed := 2000

var has_hit := false

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func _on_animation_hammer_hit() -> void:
	has_hit = false
	for area in damage_area.get_overlapping_areas():
		if area is hurtbox and not area.is_in_group("player")\
		and not has_hit:
			hit(-(_player.direction))
			has_hit = true
			pass
	if not has_hit:
		hit(_player.direction)
	pass # Replace with function body.

func hit(dir):
	has_hit = true
	_player.velocity += dir * max_thrust_speed * \
	_player.hammer_hit_strengh
	print("HIT" ," ", _player.hammer_hit_strengh," ",dir * max_thrust_speed * \
	_player.hammer_hit_strengh)

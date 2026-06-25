extends Node

class_name player_attack

@onready var hammer: Sprite2D = %Hammer
@onready var damage_area: Area2D = $"../Animation/Path2D/PathFollow2D/Damage_area"
@onready var damage_hitbox: CollisionShape2D = $"../Animation/Path2D/PathFollow2D/Damage_area/Damage_hitbox"
@onready var player_hurtbox: hurtbox = %player_hurtbox
@onready var animation_player: AnimationPlayer = $"../../platforms/AnimationPlayer"


@export var _player : player
@export var max_thrust_speed := 2000
@export var max_knockback_speed := 2400

var has_hit := false

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if _player.is_on_floor():
		has_hit = false
	pass


func _on_animation_hammer_hit() -> void:
	#for area in damage_area.get_overlapping_areas():
		#print(area ," ",area is hurtbox ," ",\
		#area.is_in_group("player") == false," ",not has_hit)
		#if area is hurtbox and (area.is_in_group("player") == false)\
		#and not has_hit:
			#print("lol")
			#hit(-(_player.direction))
			#has_hit = true
			#pass
	if not has_hit:
		hit(_player.direction , true)
	pass # Replace with function body.

func hit(dir,thrust : bool):
	has_hit = true
	if thrust :
		_player.velocity += dir * max_thrust_speed * \
		_player.hammer_hit_strengh
	else:
		_player.velocity = dir * max_knockback_speed * \
		_player.hammer_hit_strengh - _player.velocity/2


func _on_damage_area_area_entered(area: Area2D) -> void:
	if _player.spinning:
		if not area.is_in_group("is_hittable"):
			return
		if area.is_in_group("enemy") :
			print(floor(_player.hammer_hit_strengh**2 * 3))
			area.damage(floor(_player.hammer_hit_strengh** 2 * 3))
			hit(-(_player.global_position.direction_to(
				area.global_position
			)),false)
			pass
		else :
			pass
		pass
	pass # Replace with function body.

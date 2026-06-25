extends CharacterBody2D

class_name enemy

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var max_health := 1

var health := 1
var moving : bool
var can_move : bool = true
var is_falling : bool = false


func _ready() -> void:
	health = max_health

func _process(delta: float) -> void:
	
	
	if abs(velocity.x) > 0 and animation_player.is_playing() == false:
		animation_player.play("walk")
	
	if velocity.x == 0 and animation_player.current_animation == "walk":
		animation_player.pause()
		pass
	health = max(0,health)
	if health == 0 and animation_player.current_animation != "death" :
		animation_player.play("death")
		$CollisionShape2D.disabled = true
		if randi_range(1,2) == 1 and is_on_floor():
			spawn_tomen()
		await animation_player.animation_finished
		animation_player.pause()
		queue_free()
	pass

func spawn_tomen():
	var totem_ : PackedScene = load("uid://b81xjxhqtby8c")
	var _totem = totem_.instantiate()
	add_sibling(_totem)
	_totem.global_position = global_position
	_totem.enemy_path = scene_file_path


func _on_timer_timeout() -> void:
	collision_shape_2d.disabled = not collision_shape_2d.disabled
	pass # Replace with function body.

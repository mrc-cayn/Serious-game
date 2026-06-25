extends Node2D

class_name totem

@onready var timer: Timer = $Timer
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var dialoge_area: interactable = $Dialoge_area
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D


@export var cooldown := 10.0
@export var health := 1
@export var max_health := 1
@export var enemy_path : String

@export var enemy_ : enemy
@export var possible_messages : Array[String]

func _ready() -> void:
	timer.wait_time = cooldown
	gpu_particles_2d.emitting = true

func _on_timer_timeout() -> void:
	if enemy_path == null:
		return
	get_spawn()
	pass # Replace with function body.

func _process(delta: float) -> void:
	#print(health)
	health = max(0,health)
	if health == 0:
		queue_free()


func get_spawn():
	if ray_cast_2d.is_colliding() == true or enemy_path == "":
		return
	var enemy_packed_scen : PackedScene = load(enemy_path)
	var _enemy : enemy = enemy_packed_scen.instantiate()
	gpu_particles_2d.emitting = true
	add_sibling(_enemy)
	_enemy.global_position = global_position
	
	var tween = get_tree().create_tween()
	tween.tween_property(self,"modulate",Color.TRANSPARENT,1)
	await tween.finished
	queue_free()


func _on_dialoge_area_intaracted_with() -> void:
	var random_message = possible_messages.pick_random()
	# random_message = possible_messages[10]
	dialoge_area.message_list = ["you stare into the ominious totem , it whispers",
	'"'+random_message+'"']
	pass # Replace with function body.

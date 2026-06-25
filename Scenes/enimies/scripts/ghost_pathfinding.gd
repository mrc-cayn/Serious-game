extends Node2D

@export var _enemy : enemy
@export var sprite : Sprite2D
@onready var eyesight: Area2D = $eyesight
@export var speed := 80
@export var idle_speed := 20
@export var social_distance := 1200
@onready var idle_timer: Timer = $idle_timer
@onready var sprite_2d: Sprite2D = $"../Sprite2D"
@onready var timer: Timer = $"../Timer"

var player_in_range = false
var _player : player
var dir : Vector2
var target_pos : Vector2
var player_pos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_player = get_tree().get_first_node_in_group("player")
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sprite_2d.rotation = _enemy.velocity.angle()-180
	set_target_pos()
	
	pass

func _physics_process(delta: float) -> void:
	if player_in_range:
		move(speed)
	else :
		if idle_timer.time_left == 0.0 :
			idle_timer.start()
			idle()
	_enemy.move_and_slide()

func idle():
	#print("idle")
	if randi_range(0,1) == 0:
		move(idle_speed)
	else :
		dir = Vector2(randi_range(-1,1),randi_range(-1,1)).normalized()
		#print(dir)
		_enemy.velocity += dir * idle_speed
	pass

func move(_speed):
	dir = _enemy.global_position.direction_to(target_pos)
	#print(dir)
	_enemy.velocity += dir * _speed

func set_target_pos():
	var player_to_ghost_dir := \
	_player.global_position.direction_to(_enemy.global_position)
	
	target_pos = _player.global_position - (
		social_distance*player_to_ghost_dir
	)
	pass



func _on_eyesight_area_entered(area: Area2D) -> void:
	player_in_range = true
	pass # Replace with function body.


func _on_eyesight_area_exited(area: Area2D) -> void:
	player_in_range = false
	pass # Replace with function body.

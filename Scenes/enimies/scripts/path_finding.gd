extends Node2D

@export var _enemy : enemy
@export var sprite : Node2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var ray_cast_2d_2: RayCast2D = $RayCast2D2
@onready var eye_sight: RayCast2D = $Eye_sight

@export var speed := 1600
@export var jump_velocity := 2400
@export var social_distance := 1200
@export var tolerence : Vector2 = Vector2(400,48)
@export var jump_cooldown := 2.0
@export var gravity := 6400
@onready var idle_timer: Timer = $idle_timer

var _player : player
var can_jump : bool
var dir : Vector2
var target_pos : Vector2
var jump_timer : Timer

func _ready() -> void:
	_player = get_tree().get_first_node_in_group("player")
	jump_timer = Timer.new()
	add_child(jump_timer)
	jump_timer.one_shot = true
	jump_timer.wait_time = jump_cooldown
	jump_timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not _enemy.is_on_floor():
		_enemy.velocity.y += gravity * delta
	
	_enemy.move_and_slide()
	
	if not eye_sight.is_colliding() :
		idle()
		return
	
	#print(target_pos , _player.position)
	dir = _enemy.global_position.direction_to(
		_player.global_position).normalized()
	

	
	_enemy.velocity.x -= 1/100 * _enemy.velocity.x
	
	check_jumpablity()
	set_target_pos()
	
	decide_next_action()
	
	#print(target_pos , _player.global_position.x)
	
	#_enemy
	


func idle():
	if idle_timer.time_left != 0 :
		return
	idle_timer.start()
	if randi_range(-1,1) == 0:
		#rint("F")
		move(Vector2(randi_range(-1,1)*0.25,0))

func decide_next_action():
	
	if target_pos.y < _enemy.global_position.y and\
	_enemy.is_on_floor() and can_jump and\
	jump_timer.time_left == 0:
		jump()
	
	if not is_pos_correct():
		#print("DSF")
		move(dir)
	
	pass

func is_pos_correct():
	if abs(_enemy.global_position - target_pos) <= tolerence:
		return true
	else:
		#print(abs(_enemy.global_position - target_pos))
		return false



func jump():
	if not _enemy.can_move:
		return
	jump_timer.start()
	_enemy.velocity.y -= jump_velocity
	apply_jump_stretch()
	pass
func apply_jump_stretch() -> void:
	# 1. Create a new tween (this automatically overrides previous tweens 
	# on these properties, preventing glitchy overlapping animations)
	print("My sprite is: ", sprite) # <--- ADD THIS
	var tween = create_tween()
	
	# Optional: A micro-squish right before the stretch (Anticipation)
	# tween.tween_property(sprite, "scale", Vector2(1.2, 0.8), 0.05)
	
	# 2. The Stretch: Character shoots upward
	# scale.x gets thinner (0.7), scale.y gets taller (1.4)
	tween.tween_property(sprite, "scale", Vector2(0.7, 1.4), 0.1)\
	.set_trans(Tween.TRANS_SINE)
	
	# 3. The Recovery: Settle back to normal
	# Using TRANS_BOUNCE makes it feel natural and elastic
	tween.tween_property(sprite, "scale", Vector2(1.0, 1.0), 0.25)\
	.set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)

func move(_dir : Vector2):
	if not _enemy.can_move :
		_enemy.velocity.x = 0
		return
	
	#print(_dir)
	_enemy.velocity = speed * _dir

func check_jumpablity():
	if ray_cast_2d.is_colliding() or ray_cast_2d_2.is_colliding():
		can_jump = false
	else:
		can_jump = true
	#print(can_jump)

func set_target_pos():
	target_pos.x = _player.global_position.x - (
		sign(_player.global_position-_enemy.global_position).x
		* social_distance
	)
	target_pos.y = _player.global_position.y

extends Node

class_name player_movement

@export var _player : player

@onready var sprite: Sprite2D = %Sprite
@onready var hammer_loop: AnimationPlayer = %"Hammer loop"
@onready var hammer: Sprite2D = %Hammer
@onready var jump_timer: Timer = $jump_timer
@onready var cayotee_timer: Timer = $cayotee_timer

@export var walk_speed := 120
@export var max_up_velocity := 120
@export var max_non_spin_speed := 2400
@export var max_falling_velocity := 9000
@export var non_spin_speed_miltiplier := 50
@export var spin_speed_miltiplier := 5
@export var gravity_acceleration := 4000
@export var gravity_multiplier := 1.5
@export var max_jump_speed := 2000
@export var max_jump_time := 0.3
@export var cayotee_time := 0

var has_jumped := false

var _delta
func _ready() -> void:
	cayotee_timer.wait_time = cayotee_time
	jump_timer.wait_time = max_jump_time
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	_delta = delta
	handle_walking()
	
	_player.velocity.y = max(-max_up_velocity,_player.velocity.y)
	
	if Input.is_action_just_pressed("space") and can_jump():
		jump()
		pass
	
	if _player.is_on_floor():
		has_jumped = false
	
	if _player.is_falling and not has_jumped:
		cayotee_timer.start()
	
	if Input.is_action_pressed("LMB"):
		_player.spinning = true
	
	
	apply_gravity(_player)
	_player.move_and_slide()

func handle_walking():
	var input_dir : int = Input.get_axis("left","right")
	if input_dir != 0 and _player.is_on_floor() and _player.can_move:
		if not _player.spinning:
			_player.moving = true
			_player.velocity.x += input_dir * walk_speed * _delta \
			* non_spin_speed_miltiplier
		else:
			_player.velocity.x += input_dir * walk_speed * _delta \
			* spin_speed_miltiplier
	if not _player.spinning:
		_player.velocity.x = min(_player.velocity.x,max_non_spin_speed)
		_player.velocity.x = max(_player.velocity.x,-max_non_spin_speed)
	
	if not _player.spinning and _player.is_on_floor() \
	and input_dir == 0:
		_player.velocity.x = 0


func can_jump():
	if (_player.is_on_floor() or cayotee_timer.time_left > 0.0)\
	and not has_jumped and _player.can_move:
		return true
	else:
		return false

func jump():
	jump_timer.start()
	
	while Input.is_action_pressed("space"): await get_tree().process_frame
	
	if can_jump():
		has_jumped = true
		_player.velocity.y -= max_jump_speed *\
		 (max_jump_time/(jump_timer.time_left+max_jump_time))
		#print(_player.velocity.y )




func apply_gravity(body : player):
	if _player.is_on_floor():
		return
	
	if body.is_falling:
		body.velocity.y += gravity_acceleration * _delta\
		* gravity_multiplier
	if not body.is_falling:
		body.velocity.y += gravity_acceleration * _delta
	
	pass


func _on_animation_hammer_hit() -> void:
	await get_tree().create_timer(
		_player.hammer_spin_time_multiplier * _player.hammer_hit_strengh
	).timeout
	_player.spinning = false
	pass # Replace with function body.

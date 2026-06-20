extends Node2D

class_name player_animation

signal hammer_hit

@export var _player : player
@onready var hammer_timer: Timer = %Hammer_timer

@onready var hammer_loop: AnimationPlayer = %"Hammer loop"
@onready var path = $Path2D
@onready var path_follow = $Path2D/PathFollow2D

var is_waiting_to_stop: bool = false
var target_offset: float = 0.0


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("LMB"):
		hammer_timer.start()
	
	if Input.is_action_pressed("LMB"):
		hammer_loop.get_animation("Spin").loop_mode = \
		Animation.LOOP_LINEAR
		
		hammer_loop.play("Spin")
		hammer_loop.speed_scale += 2 * delta
		pass
	if Input.is_action_just_released("LMB"):
		#_player.spinning = false
		_player.hammer_hit_strengh = 1/(1+hammer_timer.time_left)
		hammer_hit.emit()
		trigger_stop_at_mouse()
	
	
	if is_waiting_to_stop:
		var current_offset = path_follow.progress
		var tolerance = 10.0 
		
		if abs(current_offset - target_offset) <= tolerance:
			hammer_loop.pause()
			path_follow.progress = target_offset 
			is_waiting_to_stop = false
			
			await get_tree().create_timer(_player.hammer_impact_time).timeout
			reset_hammer()
	pass


func trigger_stop_at_mouse():
	var mouse_pos_local = path.to_local(get_global_mouse_position())
	target_offset = path.curve.get_closest_offset(mouse_pos_local)
	is_waiting_to_stop = true
	

func reset_hammer():
	hammer_loop.play("Spin")
	
	#await get_tree().create_timer(
		#_player.hammer_spin_time_multiplier * _player.hammer_hit_strengh
	#).timeout
	
	hammer_loop.get_animation("Spin").loop_mode = \
	Animation.LOOP_NONE
	await hammer_loop.animation_finished
	hammer_loop.speed_scale = 1
	
	hammer_loop.play("Idle")

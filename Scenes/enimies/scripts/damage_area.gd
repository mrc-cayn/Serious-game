extends Area2D

signal damaged

@onready var player_timer: Timer = $player_timer

@export var player_only := false
@export var cooldown := 1.0
@export var spin_immunity := false
@export var instant := false

@export var damage := 1

var is_player_colliding := false
var player_hurtbox : hurtbox

func _ready() -> void:
	player_timer.wait_time = cooldown


func _process(delta: float) -> void:
	if player_timer.time_left == 0.0 and is_player_colliding:
		player_hurtbox.damage(damage)

func _on_area_entered(area: hurtbox) -> void:
	if area is not hurtbox:
		return
	#print(player_timer.time_left)
	if area.is_in_group("player"):
		player_timer.start()
		player_hurtbox = area
		is_player_colliding = true
		area.damage(damage)
		damaged.emit()

		#print(damage,"damagee")
	
	elif not player_only:
		area.damage(damage)
		damaged.emit()

	
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	if area is not hurtbox:
		return
	
	if area.is_in_group("player"):
		is_player_colliding = false
	pass # Replace with function body.

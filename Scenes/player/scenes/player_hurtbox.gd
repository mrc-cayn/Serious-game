extends Area2D

class_name hurtbox

@export var target : Node2D
@export var invunerable_time : float = 0.5
@onready var timer: Timer = $Timer


func damage(amount:int) :
	if timer == null :
		return
	if timer.time_left != 0 and invunerable_time != 0:
		return
	#print(amount)
	timer.start()
	target.health -= amount
	G.pause_frame(0.075)
	target.modulate = Color.RED
	await get_tree().create_timer(0.075).timeout
	target.modulate = Color.WHITE
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer != null:
		timer.wait_time = invunerable_time
	pass

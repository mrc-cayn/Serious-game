extends AnimatableBody2D


@export var moving := false 
@export var distance := 64.0
@export var duration := 1.0
@export var dir : Vector2

func _ready() -> void:
	if moving == false:
		return
	
	var orignal_pos = position
	var target_pos = position + distance*dir
	
	var tween := get_tree().create_tween().set_loops()
	tween.play()
	tween.tween_property(self,"position",
	target_pos,duration)
	tween.tween_property(self,"position",
	orignal_pos,duration)

	

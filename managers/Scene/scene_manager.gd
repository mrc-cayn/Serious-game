extends Node
@onready var animation_player: AnimationPlayer = %AnimationPlayer

var current_scene_path : String

func change_scene(target_path):
	current_scene_path = target_path
	animation_player.play("transition")
	print("changing scene to ",target_path)

func update_current_scene():
	get_tree().change_scene_to_file(current_scene_path)

func _process(delta) -> void:
	if Input.is_action_just_pressed("ui_home"):
		change_scene("res://main.tscn")

extends Node
@onready var animation_player: AnimationPlayer = %AnimationPlayer

var current_scene_path : String
var current_scene : PackedScene


func reload_scene():
	animation_player.play("transition")
	await  get_tree().create_timer(1).timeout
	get_tree().reload_current_scene()

func change_scene(target_uid : String):
	current_scene = load(target_uid)
	current_scene_path = current_scene.resource_path
	animation_player.play("transition")
	print("changing scene to "," ",target_uid," ",current_scene_path)

func update_current_scene():
	print(current_scene_path)
	get_tree().change_scene_to_file(current_scene_path)
	self.emit_signal("scene_changed")


func _process(delta) -> void:
	if Input.is_action_just_pressed("ui_home"):
		change_scene("uid://cspyvje8po63w")
		print(get_tree().current_scene)

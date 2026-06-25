extends Node
@onready var animation_player: AnimationPlayer = %AnimationPlayer

var current_scene_path : String
var current_scene : PackedScene


func reload_scene():
	animation_player.play("transition")
	await  get_tree().create_timer(1).timeout
	current_scene_path = get_tree().current_scene.scene_file_path

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
	pass

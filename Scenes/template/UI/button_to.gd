extends Control
@export var target_path : String
@export var button_object : BaseButton
@export var on_release : bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if target_path == null :
		print("scene path is null")
		return
	
	if on_release == true:
		button_object.connect("button_up",change_scene())
	
	elif on_release == false:
		button_object.connect("button_down",change_scene())
	pass # Replace with function body.

func change_scene():
	Scene_manager.change_scene(target_path)

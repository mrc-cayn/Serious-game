extends Control
@export var target_path : String
@export var button_object : BaseButton
@export var on_release : bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if target_path == null :
		print("scene path is null")
		return
	
	if button_object == null:
		await get_tree().process_frame
	
	if on_release == true:
		button_object.button_up.connect(change_scene)
	
	elif on_release == false:
		button_object.button_down.connect(change_scene)
	pass # Replace with function body.

func change_scene():
	Scene_manager.change_scene(target_path)

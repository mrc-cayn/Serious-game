extends PopupPanel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape") :
		print(visible)
		if not visible:
			visible = true
			print(visible)
		else:
			hide()
			print("Fasfafsdgdgfd")
	if not visible:
		return
	pass


func _on_return_button_button_up() -> void:
	G.resume_game()
	visible = false
	pass # Replace with function body.


func _on_restart_button_button_up() -> void:
	Scene_manager.reload_scene()
	visible = false
	pass # Replace with function body.


func _on_popup_hide() -> void:
	G.resume_game()
	pass # Replace with function body.

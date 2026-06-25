extends Control


@onready var play_button: TextureButton = $play_button
@onready var popup_panel: PopupPanel = $PopupPanel


func _on_play_button_button_up() -> void:
	popup_panel.visible = true
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		popup_panel.visible = false

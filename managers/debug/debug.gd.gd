extends Node

@onready var hud: Node2D = $HUD
@onready var canvas_layer: CanvasLayer = $HUD/CanvasLayer
@onready var time_scale: HSlider = $HUD/CanvasLayer/time_scale
@onready var time_sale_text: Label = $HUD/CanvasLayer/time_scale/time_sale_text
@onready var paused: CheckBox = $HUD/CanvasLayer/Paused

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		hud.visible = not hud.visible
		print("debug_mode")
	
	set_canvas_layer_visiblity()
	pass


func set_canvas_layer_visiblity():
	canvas_layer.visible = hud.visible


func _on_time_scale_value_changed(value: float) -> void:
	Engine.time_scale = time_scale.value
	time_sale_text.text = "Time_scale=" + str(Engine.time_scale)
	print(Engine.time_scale)
	pass # Replace with function body.


func _on_paused_toggled(toggled_on: bool) -> void:
	get_tree().paused = paused.toggle_mode
	pass # Replace with function body.

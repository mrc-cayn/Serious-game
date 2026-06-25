extends Node

var _player : player
var main_scene : Node2D
var death := false
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var current_stage := 1
signal dialouge_changed
@onready var hud: CanvasLayer = $HUD
@onready var health_bar: ProgressBar = $HUD/health_bar
@onready var paused_menu: PopupPanel = $HUD/paused_menu


func _ready() -> void:
	_player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	_player = get_tree().get_first_node_in_group("player")
	
	if Input.is_action_just_pressed("ui_home"):
		_player.health = 0
	
	if death == true:
		Scene_manager.reload_scene()
		death = false
		pause_frame(1)
		#animation_player.play("death")
		#await animation_player.animation_finished

	
	if Input.is_action_just_pressed("RMB"):
		Dialouge.disply(["hello","whats up"])
	if _player != null:
		health_bar.max_value = _player.max_health
		health_bar.value = _player.health
	
	if get_tree().current_scene != null:
		if get_tree().current_scene.is_in_group("cutscene"):
			hud.visible = false
		else :
			hud.visible = true

func pause_frame(time):
	pause_game()
	await get_tree().create_timer(time).timeout
	resume_game()

func resume_game():
	main_scene = get_tree().get_first_node_in_group("main")
	if main_scene == null:
		return
	main_scene.process_mode = Node.PROCESS_MODE_ALWAYS

func pause_game():
	main_scene = get_tree().get_first_node_in_group("main")
	if main_scene == null:
		return
	main_scene.process_mode = Node.PROCESS_MODE_DISABLED

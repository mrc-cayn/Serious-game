extends Node

var _player : player
var main_scene : Node2D
var death := false
@onready var health_bar: ProgressBar = $HUD/health_bar
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var current_stage := 1
signal dialouge_changed
@onready var hud: CanvasLayer = $HUD

func _ready() -> void:
	_player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	
	if main_scene != null:
		if hud == null:
			return
		hud.visible = true
	
	if death == true:
		Scene_manager.reload_scene()
		death = false
	if _player == null or health_bar == null:
		#print("player/HUD_not_found")
		return
	health_bar.max_value = _player.max_health
	health_bar.value = _player.health
	
	if Input.is_action_just_pressed("RMB"):
		Dialouge.disply(["hello","whats up"])
	
	if health_bar.value == 0:
		animation_player.play("death")

func pause_frame(time):
	pause_game()
	await get_tree().create_timer(time).timeout
	resume_game()

func resume_game():
	main_scene = get_tree().get_first_node_in_group("main")
	main_scene.process_mode = Node.PROCESS_MODE_ALWAYS

func pause_game():
	main_scene = get_tree().get_first_node_in_group("main")
	main_scene.process_mode = Node.PROCESS_MODE_DISABLED

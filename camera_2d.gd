extends Camera2D

@export_category("Camera Settings")
## The speed of the smooth transition.
@export var follow_speed: float = 5.0
## The size of the dynamic framing box when following ONLY the player.
@export var player_deadzone: Vector2 = Vector2(150, 150)
## Maximum screen space the player can traverse before the camera is forced to follow them (0.8 = 80% of screen).
@export_range(0.1, 1.0) var screen_edge_leash: float = 0.8

var _target_position: Vector2
var target_group := "player"
func _ready() -> void:
	
	_target_position = global_position

func _physics_process(delta: float) -> void:
	
	var view_size: Vector2 = get_viewport_rect().size / zoom
	
	# 1. Define the 75% detection area for enemies
	var center_area_size: Vector2 = view_size * 0.75
	var center_rect := Rect2(global_position - (center_area_size * 0.5), center_area_size)

	# 2. Always grab the Player globally
	var player_node: Node2D = get_tree().get_first_node_in_group(target_group) as Node2D
	if not player_node:
		return # Pause camera logic if the player hasn't loaded or is destroyed

	# 3. Filter Enemies that are inside the 75% view
	var enemies: Array[Node] = get_tree().get_nodes_in_group("camera_focus")
	var enemies_in_center: Array[Node2D] = []
	
	for enemy in enemies:
		if enemy is Node2D and center_rect.has_point(enemy.global_position):
			enemies_in_center.append(enemy)

	# 4. Core Camera Logic
	if enemies_in_center.is_empty():
		# SCENARIO A: Player is alone. Use the tight dynamic deadzone.
		_apply_deadzone(player_node.global_position, player_deadzone)
	else:
		# SCENARIO B: Enemies nearby. Center perfectly between player and enemies.
		var enemy_centroid := Vector2.ZERO
		for enemy in enemies_in_center:
			enemy_centroid += enemy.global_position
		enemy_centroid /= enemies_in_center.size()
		
		# Weight the player 50% and the enemy swarm 50% for fair visual framing
		_target_position = (player_node.global_position + enemy_centroid) / 2.0
		
		# THE SAFETY LEASH: Give the camera freedom to center, 
		# but if the player gets near the screen edge, force the camera to drag.
		var max_leash: Vector2 = view_size * screen_edge_leash
		_apply_deadzone(player_node.global_position, max_leash)

	# 5. Smooth Framerate-Independent Interpolation
	var smoothing_factor: float = 1.0 - exp(-follow_speed * delta)
	global_position = global_position.lerp(_target_position, smoothing_factor)


func _apply_deadzone(player_pos: Vector2, limit_box: Vector2) -> void:
	# Calculate how far the player is from the intended target
	var diff: Vector2 = player_pos - _target_position

	# If the distance exceeds the given bounding box, drag the target.
	if abs(diff.x) > limit_box.x / 2.0:
		_target_position.x += sign(diff.x) * (abs(diff.x) - (limit_box.x / 2.0))
		
	if abs(diff.y) > limit_box.y / 2.0:
		_target_position.y += sign(diff.y) * (abs(diff.y) - (limit_box.y / 2.0))

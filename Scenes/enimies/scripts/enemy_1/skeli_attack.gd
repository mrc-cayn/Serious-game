extends Node2D


@export var bone_scene: PackedScene
@export var fire_distance: int = 1600
@export var bone_time: float = 1
@export var attack_cooldown := 3.0
@onready var enemy_1: enemy = $".."
@onready var sprite: Node2D = $"../sprite"
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

@onready var ray_cast_l: RayCast2D = $RayCastL
@onready var ray_cast_r: RayCast2D = $RayCastR
@onready var attack_cooldown_timer: Timer = $attack_cooldown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bone_scene = preload("uid://lvnnl4wwt524")
	attack_cooldown_timer.wait_time = attack_cooldown
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir : int = check_collision_direction()
	
	if check_collision_direction() == 0:
		return
	
	if check_collision_direction() == 1:
		shoot(1)
	
	if check_collision_direction() == -1:
		shoot(-1)
	
	if sprite != null and enemy_1 != null:
		if enemy_1.velocity.x == 0 :
			return
		sprite.scale.x = sign(enemy_1.velocity.x)
	pass

func shoot(dir : int):
	if attack_cooldown_timer.time_left != 0 or enemy_1.health == 0:
		return
	animation_player.play("attack")
	enemy_1.can_move = false
	attack_cooldown_timer.start()
	await animation_player.animation_finished
	var bone : Node2D = bone_scene.instantiate()
	add_child(bone)
	bone.global_position = global_position - Vector2(-64*dir,64)
	
	var target_pos := Vector2(
	bone.global_position.x+(fire_distance * dir),
	bone.global_position.y)
	
	var tween :Tween = get_tree().create_tween()
	tween.tween_property(bone,"global_position",\
	target_pos,bone_time)
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(tween.TRANS_EXPO)
	tween.play()
	tween.tween_property(bone,"global_position",\
	enemy_1.global_position,bone_time)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(tween.TRANS_EXPO)
	tween.play()
	await tween.finished
	if bone != null:
		bone.queue_free()
	enemy_1.can_move = true
	pass

func check_collision_direction():
	
	if ray_cast_l.is_colliding():
		return(-1)
	if ray_cast_r.is_colliding():
		return(1)
	else :
		return(0)

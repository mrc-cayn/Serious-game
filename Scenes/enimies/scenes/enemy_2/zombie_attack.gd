extends Node2D

@export var attack_cooldown := 1.0
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

@export var _enemy : enemy
@export var sprite : Node2D


@onready var attack_cooldown_timer: Timer = $attack_cooldown
@onready var ray_cast_l: RayCast2D = $RayCastL
@onready var ray_cast_r: RayCast2D = $RayCastR

@onready var collision_r: CollisionShape2D = $Damage_areaR/CollisionR
@onready var collision_l: CollisionShape2D = $Damage_areaL/CollisionL

func _ready() -> void:
	attack_cooldown_timer.wait_time = attack_cooldown


func _process(delta: float) -> void:
	

	
	if ray_cast_l.is_colliding():
		#print("f")
		attack(-1)
	if ray_cast_r.is_colliding():
		#print("Gefqz")
		attack(1)

	else:
		disable_damage_collision()


func _physics_process(delta: float) -> void:
	if sprite != null and _enemy != null:
			if _enemy.velocity.x == 0 :
				return
			sprite.scale.x = sign(_enemy.velocity.x)
			self.scale.x = sign(_enemy.velocity.x)

func disable_damage_collision():
	collision_l.disabled = true
	collision_r.disabled = true

func attack(dir : int):
	#print(attack_cooldown_timer.time_left)
	if attack_cooldown_timer.time_left != 0.0:
		return
	
	attack_cooldown_timer.start()
	
	animation_player.play("attack")
	
	if dir == -1:
		collision_l.disabled = false
	
	if dir == 1:
		collision_r.disabled = false
	
	
	pass

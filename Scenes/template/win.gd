extends Area2D


@export var target_path : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	G.current_stage = int(get_parent().name.right(1))
	print(get_parent().name.right(1))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	Scene_manager.change_scene(target_path)
	

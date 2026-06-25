extends Node2D


@export var dialoge : Array[String]
@export var start := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialouge.disply(dialoge,60,
	"res://assets/sprites/question_mark.png")
	G.dialouge_changed.connect(dialouge_changed)
	G.resume_game()

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_end"):
		Scene_manager.change_scene("uid://cg8vefxpkkjjj")
	pass

var dialouge_index := 1
func dialouge_changed():
	dialouge_index += 1
	update_animation()
	pass

func update_animation():
	#if dialouge_index != 2:
	get_node(str(dialouge_index-1)).visible = false
	if dialouge_index <= 11:
		get_node(str(dialouge_index)).visible = true
	else :
		if start:
			Scene_manager.change_scene("uid://cg8vefxpkkjjj")
		else:
			Scene_manager.change_scene("res://Scenes/cutscenes/win_screen.tscn")
	pass

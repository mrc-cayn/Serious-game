extends Area2D

class_name interactable

signal intaracted_with

var player_colliding := false
@export var icon : CanvasItem
@export var message_list : Array[String]
@export var text_speed : float = 20
@export var potrait_path : String = "res://icon.svg"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	
	if not player_colliding :
		icon.visible = false
		return
	
	icon.visible = true
	
	if Input.is_action_just_pressed("e"):
		intaracted_with.emit()
		Dialouge.disply(
			message_list,text_speed,potrait_path
		)



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_colliding = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_colliding = false
	pass # Replace with function body.

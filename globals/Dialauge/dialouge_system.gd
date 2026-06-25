extends Node2D

@onready var label: RichTextLabel = $CanvasLayer/TextureRect/Label
@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer
@onready var sprite_2d: Sprite2D = %Sprite2D


func disply(message_list : Array ,text_speed : float = 12.0 
	,potrait_path : String = "res://icon.svg",):
	G.pause_game()
	animation_player.play("Appear")
	sprite_2d.texture = load(potrait_path)
	print(sprite_2d.texture.get_size()/512)
	sprite_2d.scale = Vector2.ONE/(sprite_2d.texture.get_size()/128)
	
	for message:String in message_list:
		label.visible_ratio = 0
		label.text = message
		var time = (label.text.length())/text_speed
		print(time)
		
		var tween = get_tree().create_tween()
		tween.tween_property(label,"visible_ratio",1,time)
		tween.play()
		await tween.finished
		while not Input.is_action_just_pressed("e") or Input.is_action_just_pressed("ui_accept"):
			await get_tree().process_frame
		G.dialouge_changed.emit()
	
	animation_player.play_backwards("Appear")
	G.resume_game()
	
	pass

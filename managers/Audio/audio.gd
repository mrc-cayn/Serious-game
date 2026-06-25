extends Node

@onready var music: AudioStreamPlayer = $music

func _ready() -> void:
	music.play()

func _process(delta: float) -> void:
	if music.stream == null:
		return
	print(G.current_stage == 2,not get_tree().current_scene.is_in_group("cutscene"), music.stream.resource_path \
	!= "res://assets/audio/music/2 Drink.mp3")
	if get_tree().current_scene.is_in_group("cutscene") and music.stream.resource_path \
	!= "res://assets/audio/music/Little Moments.mp3":
		play_music("res://assets/audio/music/Little Moments.mp3")
	elif G.current_stage == 1 and music.stream.resource_path \
	!= "res://assets/audio/music/1 Drink.mp3" and not get_tree().current_scene.is_in_group("cutscene"):
		play_music("res://assets/audio/music/1 Drink.mp3")
		pass
	elif G.current_stage == 2 and music.stream.resource_path \
	!= "res://assets/audio/music/2 Drinks.mp3" and not get_tree().current_scene.is_in_group("cutscene") :
		play_music("res://assets/audio/music/2 Drinks.mp3")
		print("lol")
		pass
	elif G.current_stage == 3 and music.stream.resource_path \
	!= "res://assets/audio/music/3 Drinks.mp3" and not get_tree().current_scene.is_in_group("cutscene") :
		play_music("res://assets/audio/music/3 Drinks.mp3")
		pass
	elif G.current_stage == 4 and music.stream.resource_path \
	!= "res://assets/audio/music/3 Drinks.mp3" and not get_tree().current_scene.is_in_group("cutscene") :
		play_music("res://assets/audio/music/3 Drinks.mp3")
		pass
	

func play_music(music_path : String):
	if music_path == null:
		return
	var new_music := load(music_path)
	music_fade(music,0.0,1)
	print(music_path , new_music)
	await get_tree().create_timer(1).timeout
	music.stream = new_music
	music.play()
	music_fade(music,12.0,1)
	#print(music.stream.resource_path)

func music_fade(audio_player,
	 final_volume_db: float = 0.0,
	 fade_time: float = 1.0):
	audio_player.volume_db = -80.0
	var tween = create_tween()
	tween.tween_property(audio_player,
	 "volume_db", final_volume_db, fade_time)
	tween.set_ease(Tween.EASE_OUT)
	pass
